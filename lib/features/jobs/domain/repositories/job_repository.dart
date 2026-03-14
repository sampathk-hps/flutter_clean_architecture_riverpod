import '../entities/job.dart';
import '../entities/job_update.dart';

abstract class JobRepository {
  Future<List<Job>> getJobs({bool refresh = false});
  Stream<List<Job>> watchJobs();
  Future<Job?> getJobById(String jobId);

  Future<void> queueJobUpdate(JobUpdate update);
  Future<void> refreshJobsFromRemote();
  Future<void> syncPendingUpdates();
}
