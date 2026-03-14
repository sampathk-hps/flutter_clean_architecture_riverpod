import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_keys.dart';

class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> writeAuthToken(String token) =>
      _storage.write(key: SecureStorageKeys.authToken, value: token);
  Future<String?> readAuthToken() =>
      _storage.read(key: SecureStorageKeys.authToken);

  Future<void> writeRefreshToken(String token) =>
      _storage.write(key: SecureStorageKeys.refreshToken, value: token);
  Future<String?> readRefreshToken() =>
      _storage.read(key: SecureStorageKeys.refreshToken);

  Future<void> writeMPin(String mPin) =>
      _storage.write(key: SecureStorageKeys.mPin, value: mPin);
  Future<String?> readMPin() => _storage.read(key: SecureStorageKeys.mPin);

  Future<void> writeSessionInfo(String sessionJson) =>
      _storage.write(key: SecureStorageKeys.sessionInfo, value: sessionJson);
  Future<String?> readSessionInfo() =>
      _storage.read(key: SecureStorageKeys.sessionInfo);

  Future<void> clearSession() async {
    for (final key in SecureStorageKeys.sessionKeys) {
      await _storage.delete(key: key);
    }
  }

  Future<void> clearAll() => _storage.deleteAll();
}
