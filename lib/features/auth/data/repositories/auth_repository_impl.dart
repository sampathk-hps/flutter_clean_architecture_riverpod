import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required SecureStorageService secureStorage,
  }) : _remote = remote,
       _secureStorage = secureStorage;

  final AuthRemoteDataSource _remote;
  final SecureStorageService _secureStorage;

  @override
  Future<Session> login({
    required String username,
    required String password,
  }) async {
    final payload = await _remote.login(username: username, password: password);

    final session = Session(
      userId: (payload['userId'] as String?) ?? username,
      accessToken: (payload['accessToken'] as String?) ?? 'local_access_token',
      refreshToken:
          (payload['refreshToken'] as String?) ?? 'local_refresh_token',
    );

    await _secureStorage.writeAuthToken(session.accessToken);
    await _secureStorage.writeRefreshToken(session.refreshToken);

    return session;
  }

  @override
  Future<void> logout() => _secureStorage.clearSession();
}
