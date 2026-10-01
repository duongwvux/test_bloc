import 'package:prj/features/domain/entities/api_user.dart';

sealed class UserDetailState {
  const UserDetailState();
}

final class UserDetailInitial extends UserDetailState {
  const UserDetailInitial();
}

final class UserDetailLoaded extends UserDetailState {
  final ApiUser user;

  const UserDetailLoaded(this.user);
}

final class UserDetailFailure extends UserDetailState {
  final String message;

  const UserDetailFailure(this.message);
}