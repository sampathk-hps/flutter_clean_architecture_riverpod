import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../network/api_client.dart';
import '../network/api_error_handler.dart';
import '../network/api_interceptor.dart';
import 'logging_providers.dart';
import 'storage_providers.dart';

final apiErrorHandlerProvider = Provider<ApiErrorHandler>(
  (ref) => ApiErrorHandler(),
);

final dioProvider = Provider<Dio>((ref) {
  final logger = ref.watch(appLoggerProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  final baseOptions = BaseOptions(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    headers: {'Content-Type': 'application/json'},
  );

  final dio = Dio(baseOptions);
  final refreshDio = Dio(baseOptions);

  dio.interceptors.add(
    ApiInterceptor(
      dio: dio,
      refreshDio: refreshDio,
      secureStorageService: secureStorage,
      logger: logger,
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (message) => logger.d(message.toString()),
    ),
  );

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});
