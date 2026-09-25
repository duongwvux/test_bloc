import 'package:prj/features/domain/entities/api_user.dart';

abstract interface class UserRepository {
  Future<List<ApiUser>> loadUsers();
  void close();
}