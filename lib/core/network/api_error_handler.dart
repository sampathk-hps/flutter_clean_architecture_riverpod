import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiErrorHandler {
  ApiError handle(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final message = _messageFromResponse(error) ?? _fallbackMessage(error);

      return ApiError(
        message: message,
        statusCode: statusCode,
        isNetworkError:
            error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout,
      );
    }

    return ApiError(message: 'Unexpected error: $error');
  }

  String? _messageFromResponse(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return null;
  }

  String _fallbackMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badCertificate:
        return 'Server certificate is invalid.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badResponse:
        return 'Server returned an error.';
      case DioExceptionType.unknown:
        return 'Unexpected network error.';
    }
  }
}
