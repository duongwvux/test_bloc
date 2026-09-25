import 'package:prj/features/domain/entities/auth_user.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  User? _currentUser;

  User? get currentUser => _currentUser;

  @override
  Future<bool> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (email.trim() != 'demo@example.com' || password != 'password123') {
      return false;
    }

    _currentUser = User(1, 'demo@example.com', 'Demo User');
    return true;
  }

  @override
  Future<bool> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }
}
