import 'dart:async';

import '../../../core/connectivity/connectivity_service.dart';
import '../../../core/logger/app_logger.dart';
import '../../jobs/domain/repositories/job_repository.dart';

class SyncManager {
  SyncManager({
    required JobRepository jobRepository,
    required ConnectivityService connectivityService,
    required AppLogger logger,
  }) : _jobRepository = jobRepository,
       _connectivityService = connectivityService,
       _logger = logger;

  final JobRepository _jobRepository;
  final ConnectivityService _connectivityService;
  final AppLogger _logger;

  StreamSubscription<ConnectivityStatus>? _connectivitySubscription;
  bool _isSyncing = false;

  void start() {
    _connectivitySubscription ??= _connectivityService.statusStream.listen(
      (status) => _onConnectivityChange(status),
    );

    if (_connectivityService.isOnline) {
      unawaited(syncNow());
    }
  }

  Future<void> _onConnectivityChange(ConnectivityStatus status) async {
    if (status == ConnectivityStatus.online) {
      await syncNow();
    }
  }

  Future<void> syncNow() async {
    if (_isSyncing) {
      return;
    }

    _isSyncing = true;

    try {
      _logger.i('Background sync started.');
      await _jobRepository.syncPendingUpdates();
      await _jobRepository.refreshJobsFromRemote();
      _logger.i('Background sync completed.');
    } catch (error, stackTrace) {
      _logger.e('Background sync failed.', error, stackTrace);
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }
}
