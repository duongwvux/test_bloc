import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import 'package:prj/features/presentation/register/bloc/register_event.dart';
import 'package:prj/features/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  RegisterBloc(this._authRepository) : super(const RegisterInitial()) {
    on<RegisterRequest>(_onRegisterRequest);
  }

  Future<void> _onRegisterRequest(
      RegisterRequest event,
      Emitter<RegisterState> emit,
  ) async {
    if (state is RegisterLoading || state is RegisterSuccess) return;

    final email = event.email.trim();
    final password = event.password;

    if (email.isEmpty || password.isEmpty) {
      emit(const RegisterFailure("Vui lòng nhập email và mật khẩu"));
      return;
    }

    emit(const RegisterLoading());

    try {
      final success = await _authRepository.register(email, password);

      if (emit.isDone) return;

      if (success) {
        emit(const RegisterSuccess());
      } else {
        emit(const RegisterFailure("Không thể đăng ký."));
      }
    } catch (_) {
      if (emit.isDone) return;
      emit(const RegisterFailure("Không thể lưu tài khoản"));
    }
  }
}