abstract final class AppConfig {
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  // Future-friendly compile-time settings.
  static const appFlavor = String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'dev',
  );
  static const enableNetworkLogs = bool.fromEnvironment(
    'ENABLE_NETWORK_LOGS',
    defaultValue: false,
  );
  static const syncBatchSize = int.fromEnvironment(
    'SYNC_BATCH_SIZE',
    defaultValue: 50,
  );

  static void validate() {
    if (apiBaseUrl.trim().isEmpty) {
      throw StateError(
        'Missing required compile-time variable: API_BASE_URL.\n'
        'Run with --dart-define=API_BASE_URL=... or '
        '--dart-define-from-file=<path-to-json>.',
      );
    }

    final parsed = Uri.tryParse(apiBaseUrl);
    final isValidUrl =
        parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https') &&
        parsed.host.isNotEmpty;

    if (!isValidUrl) {
      throw StateError(
        'Invalid API_BASE_URL: "$apiBaseUrl". '
        'Expected an absolute http/https URL.',
      );
    }
  }
}
