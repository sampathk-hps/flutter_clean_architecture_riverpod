import '../entities/session.dart';

abstract class AuthRepository {
  Future<Session> login({required String username, required String password});
  Future<void> logout();
}
