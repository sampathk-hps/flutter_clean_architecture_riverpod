import 'package:isar_community/isar.dart';

import '../../../../core/database/collections/job_collection.dart';
import '../../../../core/database/collections/job_update_collection.dart';
import '../../../../core/database/collections/sync_queue_collection.dart';
import '../../../../core/database/isar_service.dart';
import '../../../../core/logger/app_logger.dart';

class JobsLocalDataSource {
  JobsLocalDataSource({
    required IsarService isarService,
    required AppLogger logger,
  }) : _isarService = isarService,
       _logger = logger;

  final IsarService _isarService;
  final AppLogger _logger;

  Future<List<JobCollection>> getAllJobs() {
    return _isarService.jobs.where().sortByUpdatedAtDesc().findAll();
  }

  Stream<List<JobCollection>> watchJobs() {
    return _isarService.jobs.where().sortByUpdatedAtDesc().watch(
      fireImmediately: true,
    );
  }

  Future<JobCollection?> getJobById(String jobId) {
    return _isarService.jobs.filter().jobIdEqualTo(jobId).findFirst();
  }

  Future<void> upsertJobs(List<JobCollection> jobs) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.jobs.putAll(jobs);
    });
  }

  Future<void> saveUpdateAndQueue({
    required JobUpdateCollection update,
    required SyncQueueCollection queue,
  }) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.jobUpdates.put(update);
      await _isarService.syncQueue.put(queue);
    });
  }

  Future<List<SyncQueueCollection>> getPendingQueueItems() async {
    final all = await _isarService.syncQueue
        .where()
        .sortByCreatedAt()
        .findAll();
    final now = DateTime.now();

    return all
        .where(
          (item) => item.nextRetryAt == null || item.nextRetryAt!.isBefore(now),
        )
        .toList();
  }

  Future<void> markJobUpdateSynced(String updateId) async {
    final update = await _isarService.jobUpdates
        .filter()
        .updateIdEqualTo(updateId)
        .findFirst();
    if (update == null) {
      return;
    }

    update.isSynced = true;

    await _isarService.instance.writeTxn(() async {
      await _isarService.jobUpdates.put(update);
    });
  }

  Future<void> removeQueueItem(int isarId) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.syncQueue.delete(isarId);
    });
  }

  Future<void> updateQueueRetry({
    required SyncQueueCollection queueItem,
    required int retryCount,
    required DateTime nextRetryAt,
    required String message,
  }) async {
    queueItem.retryCount = retryCount;
    queueItem.nextRetryAt = nextRetryAt;
    queueItem.lastError = message;

    await _isarService.instance.writeTxn(() async {
      await _isarService.syncQueue.put(queueItem);
    });
  }

  void logSyncFailure(String message, Object error, StackTrace stackTrace) {
    _logger.e(message, error, stackTrace);
  }
}
