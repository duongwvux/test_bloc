import 'package:prj/features/data/security/password_hasher.dart';
import 'package:prj/features/domain/entities/auth_user.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAuthRepository implements AuthRepository {
  final Database _database;
  final PasswordHasher _passwordHasher;

  User? _currentUser;

  User? get currentUser => _currentUser;

  DatabaseAuthRepository({
    required Database database,
    required PasswordHasher passwordHasher,
  }) : _database = database,
       _passwordHasher = passwordHasher;
  String _normalizeEmail(String email) => email.trim().toLowerCase();

  @override
  Future<bool> register(String email, String password) async {
    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail.isEmpty || password.isEmpty) {
      return false;
    }

    final encodedHash = await _passwordHasher.hash(password);

    try {
      await _database.insert(
          'users',
          {
            'email': normalizedEmail,
            'password_hash': encodedHash,
          }
      );
      return true;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        return false;
      }

      rethrow;
    }
  }

  @override
  Future<bool> login(String email, String password) async {
    final rows = await _database.query(
        'users',
      where: 'email = ?',
      whereArgs: [_normalizeEmail(email)],
      limit: 1,
    );

    if (rows.isEmpty) return false;

    final row = rows.first;
    final valid = await _passwordHasher.verify(
        password,
        row['password_hash'] as String,
    );

    if (!valid) return false;

    final storedEmail = row['email'] as String;
    _currentUser = User(
        row['id'] as int,
        storedEmail,
        storedEmail.split('@').first,
    );

    return true;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }
}