import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/connectivity_providers.dart';
import '../../../core/di/logging_providers.dart';
import '../../jobs/di/jobs_providers.dart';
import '../domain/sync_manager.dart';

final syncManagerProvider = Provider<SyncManager>((ref) {
  final manager = SyncManager(
    jobRepository: ref.watch(jobRepositoryProvider),
    connectivityService: ref.watch(connectivityServiceProvider),
    logger: ref.watch(appLoggerProvider),
  );

  ref.onDispose(manager.dispose);

  return manager;
});
