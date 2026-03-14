import 'dart:async';

import 'package:dio/dio.dart';

import '../logger/app_logger.dart';
import '../storage/secure_storage_service.dart';
import 'api_endpoints.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    required Dio dio,
    required Dio refreshDio,
    required SecureStorageService secureStorageService,
    required AppLogger logger,
  }) : _dio = dio,
       _refreshDio = refreshDio,
       _secureStorageService = secureStorageService,
       _logger = logger;

  final Dio _dio;
  final Dio _refreshDio;
  final SecureStorageService _secureStorageService;
  final AppLogger _logger;

  Future<String?>? _refreshTokenFuture;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorageService.readAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final alreadyRetried = err.requestOptions.extra['retried'] == true;

    if (statusCode == 401 && !alreadyRetried) {
      final freshToken = await _refreshAccessToken();
      if (freshToken != null) {
        try {
          final requestOptions = err.requestOptions;
          requestOptions.extra['retried'] = true;
          requestOptions.headers['Authorization'] = 'Bearer $freshToken';

          final response = await _dio.fetch(requestOptions);
          handler.resolve(response);
          return;
        } catch (retryError, stackTrace) {
          _logger.e(
            'Retry after token refresh failed.',
            retryError,
            stackTrace,
          );
        }
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    if (_refreshTokenFuture != null) {
      return _refreshTokenFuture;
    }

    _refreshTokenFuture = _refreshAccessTokenInternal();

    try {
      return await _refreshTokenFuture;
    } finally {
      _refreshTokenFuture = null;
    }
  }

  Future<String?> _refreshAccessTokenInternal() async {
    final refreshToken = await _secureStorageService.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final body = response.data ?? <String, dynamic>{};
      final accessToken = body['accessToken'] as String?;
      final newRefreshToken = body['refreshToken'] as String?;

      if (accessToken == null || accessToken.isEmpty) {
        return null;
      }

      await _secureStorageService.writeAuthToken(accessToken);
      if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
        await _secureStorageService.writeRefreshToken(newRefreshToken);
      }

      _logger.i('Access token refreshed successfully.');
      return accessToken;
    } catch (error, stackTrace) {
      _logger.e('Failed to refresh token.', error, stackTrace);
      await _secureStorageService.clearSession();
      return null;
    }
  }
}
