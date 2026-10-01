import 'package:prj/features/domain/entities/api_user.dart';

sealed class UserDetailEvent {
  const UserDetailEvent();
}

final class UserDetailOpened extends UserDetailEvent {
  final ApiUser user;

  const UserDetailOpened(this.user);
}

