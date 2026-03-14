import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_error_handler.dart';
import '../models/job_api_model.dart';
import '../models/job_update_payload.dart';

class JobsRemoteDataSource {
  JobsRemoteDataSource({
    required ApiClient apiClient,
    required ApiErrorHandler errorHandler,
  }) : _apiClient = apiClient,
       _errorHandler = errorHandler;

  final ApiClient _apiClient;
  final ApiErrorHandler _errorHandler;

  Future<List<JobApiModel>> fetchJobs() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.jobs);
      final data = response.data;

      final rawList = switch (data) {
        {'data': final List<dynamic> list} => list,
        List<dynamic> list => list,
        _ => <dynamic>[],
      };

      return rawList
          .whereType<Map<String, dynamic>>()
          .map(JobApiModel.fromJson)
          .toList(growable: false);
    } catch (error) {
      throw ApiException(_errorHandler.handle(error));
    }
  }

  Future<JobApiModel?> fetchJobById(String jobId) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.jobById(jobId));
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final body = data['data'];
        if (body is Map<String, dynamic>) {
          return JobApiModel.fromJson(body);
        }

        return JobApiModel.fromJson(data);
      }

      return null;
    } catch (error) {
      throw ApiException(_errorHandler.handle(error));
    }
  }

  Future<void> pushJobUpdate(JobUpdatePayload payload) async {
    try {
      await _apiClient.post(ApiEndpoints.jobUpdates, data: payload.toJson());
    } catch (error) {
      throw ApiException(_errorHandler.handle(error));
    }
  }
}
