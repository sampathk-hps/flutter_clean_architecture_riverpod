abstract final class ApiEndpoints {
  static const login = '/auth/login';
  static const refreshToken = '/auth/refresh-token';

  static const jobs = '/jobs';
  static String jobById(String id) => '/jobs/$id';
  static const jobUpdates = '/job-updates';
}
