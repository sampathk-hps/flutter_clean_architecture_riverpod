import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/api_providers.dart';
import '../../../core/di/connectivity_providers.dart';
import '../../../core/di/logging_providers.dart';
import '../../../core/di/storage_providers.dart';
import '../data/datasources/jobs_local_datasource.dart';
import '../data/datasources/jobs_remote_datasource.dart';
import '../data/repositories/job_repository_impl.dart';
import '../domain/entities/job.dart';
import '../domain/repositories/job_repository.dart';

final jobsLocalDataSourceProvider = Provider<JobsLocalDataSource>((ref) {
  return JobsLocalDataSource(
    isarService: ref.watch(isarServiceProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final jobsRemoteDataSourceProvider = Provider<JobsRemoteDataSource>((ref) {
  return JobsRemoteDataSource(
    apiClient: ref.watch(apiClientProvider),
    errorHandler: ref.watch(apiErrorHandlerProvider),
  );
});

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepositoryImpl(
    local: ref.watch(jobsLocalDataSourceProvider),
    remote: ref.watch(jobsRemoteDataSourceProvider),
    connectivity: ref.watch(connectivityServiceProvider),
    logger: ref.watch(appLoggerProvider),
  );
});

final jobByIdProvider = FutureProvider.family<Job?, String>((ref, jobId) async {
  return ref.watch(jobRepositoryProvider).getJobById(jobId);
});
