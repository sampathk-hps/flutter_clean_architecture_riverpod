import 'dart:async';
import 'dart:convert';

import '../../../../core/connectivity/connectivity_service.dart';
import '../../../../core/database/collections/sync_queue_collection.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/api_error.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/job_update.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/jobs_local_datasource.dart';
import '../datasources/jobs_remote_datasource.dart';
import '../models/job_mappers.dart';
import '../models/job_update_payload.dart';

class JobRepositoryImpl implements JobRepository {
  JobRepositoryImpl({
    required JobsLocalDataSource local,
    required JobsRemoteDataSource remote,
    required ConnectivityService connectivity,
    required AppLogger logger,
  }) : _local = local,
       _remote = remote,
       _connectivity = connectivity,
       _logger = logger;

  final JobsLocalDataSource _local;
  final JobsRemoteDataSource _remote;
  final ConnectivityService _connectivity;
  final AppLogger _logger;

  @override
  Future<List<Job>> getJobs({bool refresh = false}) async {
    final localJobs = (await _local.getAllJobs())
        .map((e) => e.toEntity())
        .toList(growable: false);

    if (!_connectivity.isOnline) {
      return localJobs;
    }

    if (refresh || localJobs.isEmpty) {
      try {
        final remoteJobs = await _remote.fetchJobs();
        await _local.upsertJobs(
          remoteJobs.map((e) => e.toCollection()).toList(growable: false),
        );
        return remoteJobs.map((e) => e.toEntity()).toList(growable: false);
      } catch (error, stackTrace) {
        _logger.w(
          'Remote fetch failed. Falling back to local cache.',
          error,
          stackTrace,
        );
      }
    }

    if (localJobs.isNotEmpty) {
      return localJobs;
    }

    return localJobs;
  }

  @override
  Stream<List<Job>> watchJobs() {
    return _local.watchJobs().map(
      (items) => items.map((e) => e.toEntity()).toList(growable: false),
    );
  }

  @override
  Future<Job?> getJobById(String jobId) async {
    final localJob = await _local.getJobById(jobId);
    if (localJob != null) {
      return localJob.toEntity();
    }

    if (!_connectivity.isOnline) {
      return null;
    }

    final remoteJob = await _remote.fetchJobById(jobId);
    if (remoteJob == null) {
      return null;
    }

    await _local.upsertJobs([remoteJob.toCollection()]);
    return remoteJob.toEntity();
  }

  @override
  Future<void> queueJobUpdate(JobUpdate update) async {
    final updateCollection = update.toCollection(isSynced: false);

    final queue = SyncQueueCollection()
      ..queueId = '${update.updateId}_${DateTime.now().millisecondsSinceEpoch}'
      ..createdAt = DateTime.now()
      ..entityType = AppConstants.syncEntityJobUpdate
      ..entityId = update.jobId
      ..operation = AppConstants.syncOperationCreate
      ..payloadJson = jsonEncode(update.toPayload().toJson())
      ..retryCount = 0;

    await _local.saveUpdateAndQueue(update: updateCollection, queue: queue);

    if (_connectivity.isOnline) {
      unawaited(syncPendingUpdates());
    }
  }

  @override
  Future<void> refreshJobsFromRemote() async {
    if (!_connectivity.isOnline) {
      return;
    }

    final remoteJobs = await _remote.fetchJobs();
    await _local.upsertJobs(
      remoteJobs.map((e) => e.toCollection()).toList(growable: false),
    );
  }

  @override
  Future<void> syncPendingUpdates() async {
    if (!_connectivity.isOnline) {
      return;
    }

    final pendingItems = await _local.getPendingQueueItems();

    for (final item in pendingItems) {
      if (item.entityType != AppConstants.syncEntityJobUpdate) {
        continue;
      }

      try {
        final payloadMap = jsonDecode(item.payloadJson);
        if (payloadMap is! Map<String, dynamic>) {
          continue;
        }

        final payload = JobUpdatePayload.fromJson(payloadMap);
        await _remote.pushJobUpdate(payload);

        await _local.markJobUpdateSynced(payload.updateId);
        await _local.removeQueueItem(item.id);
      } on ApiException catch (apiException, stackTrace) {
        await _handleSyncFailure(
          item: item,
          apiException: apiException,
          stackTrace: stackTrace,
        );
      } catch (error, stackTrace) {
        _local.logSyncFailure('Unexpected sync error', error, stackTrace);
      }
    }
  }

  Future<void> _handleSyncFailure({
    required SyncQueueCollection item,
    required ApiException apiException,
    required StackTrace stackTrace,
  }) async {
    final statusCode = apiException.error.statusCode;

    if (statusCode == 409) {
      _logger.w(
        'Conflict detected for queue ${item.queueId}. Using server state (last-write-wins).',
      );
      final syncedJob = await _remote.fetchJobById(item.entityId);
      if (syncedJob != null) {
        await _local.upsertJobs([syncedJob.toCollection()]);
      }
      await _local.removeQueueItem(item.id);
      return;
    }

    final retries = item.retryCount + 1;
    if (retries > AppConstants.maxSyncRetryCount) {
      _logger.e('Queue item ${item.queueId} reached max retries.');
      return;
    }

    final nextRetryAt = DateTime.now().add(
      Duration(minutes: retries * retries),
    );

    await _local.updateQueueRetry(
      queueItem: item,
      retryCount: retries,
      nextRetryAt: nextRetryAt,
      message: apiException.error.message,
    );

    _logger.w(
      'Sync retry scheduled for queue ${item.queueId} at $nextRetryAt',
      apiException,
      stackTrace,
    );
  }
}
