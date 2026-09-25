import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/repositories/user_repository.dart';
import 'package:prj/features/presentation/user/bloc/user_event.dart';
import 'package:prj/features/presentation/user/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(const UserInitial()) {
    on<UsersRequested>(_onUsersRequested);
  }

  Future<void> _onUsersRequested(
      UsersRequested event,
      Emitter<UserState> emit,
  ) async {
    if (state is UserLoading) return;

    emit(const UserLoading());

    try {
      final users = await _userRepository.loadUsers();

      if (emit.isDone) return;
      emit(UserLoaded(users));
    } on TimeoutException {
      if (emit.isDone) return;
      emit (const UserFailure('Hết thời gian chờ API'));
    } on FormatException {
      if (emit.isDone) return;
      emit(const UserFailure('Dữ liệu API không đúng'));
    } catch (error, stackTrace) {
      developer.log(
        'Không tải được danh sách.',
        name: 'UserBloc',
        error: error,
        stackTrace: stackTrace,
      );
      if (emit.isDone) return;
      emit(const UserFailure('Không tải được danh sách.'));
    }
  }
}