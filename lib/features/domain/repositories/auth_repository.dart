import 'package:prj/features/domain/entities/auth_user.dart';

abstract interface class GetCurrentUser {
  User getUser(int id);
}

abstract interface class AuthRepository {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
  Future<void> logout();
}