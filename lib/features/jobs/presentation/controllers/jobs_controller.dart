import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/job.dart';
import '../../domain/entities/job_update.dart';
import '../../domain/repositories/job_repository.dart';
import '../../di/jobs_providers.dart';

final jobsControllerProvider = AsyncNotifierProvider<JobsController, List<Job>>(
  JobsController.new,
);

class JobsController extends AsyncNotifier<List<Job>> {
  StreamSubscription<List<Job>>? _watchSubscription;

  JobRepository get _repository => ref.read(jobRepositoryProvider);

  @override
  Future<List<Job>> build() async {
    _watchSubscription?.cancel();
    _watchSubscription = _repository.watchJobs().listen((jobs) {
      state = AsyncData(jobs);
    });

    ref.onDispose(() => _watchSubscription?.cancel());

    return _repository.getJobs();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.refreshJobsFromRemote();
      return _repository.getJobs(refresh: true);
    });
  }

  Future<void> submitUpdate({
    required String jobId,
    required String? note,
    required String status,
    String? imagePath,
  }) async {
    final update = JobUpdate(
      updateId: '${jobId}_${DateTime.now().millisecondsSinceEpoch}',
      jobId: jobId,
      notes: note,
      status: status,
      imagePath: imagePath,
      createdAt: DateTime.now(),
    );

    await _repository.queueJobUpdate(update);
  }
}
