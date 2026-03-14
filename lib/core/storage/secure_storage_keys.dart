abstract final class SecureStorageKeys {
  static const authToken = 'auth_token';
  static const refreshToken = 'refresh_token';
  static const mPin = 'mpin';
  static const sessionInfo = 'session_info';

  static const sessionKeys = <String>[
    authToken,
    refreshToken,
    sessionInfo,
  ];
}
