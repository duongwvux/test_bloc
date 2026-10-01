import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/presentation/user_detail/bloc/user_detail_event.dart';
import 'package:prj/features/presentation/user_detail/bloc/user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(const UserDetailInitial()) {
    on<UserDetailOpened>(_onOpened);
  }

  void _onOpened(
      UserDetailOpened event,
      Emitter<UserDetailState> emit,
  ) {
    if (event.user.id.isEmpty) {
      emit(const UserDetailFailure('ID không hợp lệ'));
      return;
    }

    emit(UserDetailLoaded(event.user));
  }
}