class ApiError {
  const ApiError({
    required this.message,
    this.statusCode,
    this.isNetworkError = false,
  });

  final String message;
  final int? statusCode;
  final bool isNetworkError;
}

class ApiException implements Exception {
  const ApiException(this.error);

  final ApiError error;

  @override
  String toString() =>
      'ApiException(statusCode: ${error.statusCode}, message: ${error.message})';
}
