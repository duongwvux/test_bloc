import 'package:prj/features/domain/entities/api_user.dart';

sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
}

final class UserLoading extends UserState {
  const UserLoading();
}

final class UserLoaded extends UserState {
  final List<ApiUser> users;
  const UserLoaded(this.users);
}

final class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);
}