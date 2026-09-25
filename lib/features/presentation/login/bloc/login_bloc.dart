import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/features/domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(const LoginState('')) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<RegisterRequest>(_onRegisterRequest);
  }

  Future<void> _onAuthLoginRequested(
      AuthLoginRequested event,
      Emitter<LoginState> emit,
  ) async {
    if (state is AuthLoading) return;
    
    emit(const AuthLoading());
    
    try {
      final success = await _authRepository.login(
          event.email.trim(), 
          event.password,
      );
      
      if (emit.isDone) return;
      
      if (success) {
        emit(const Authenticated());
      } else {
        emit(const LoginFailure('Email hoặc mật khẩu không đúng.'));
      }
    } catch (_) {
      if (emit.isDone) return;
      
      emit(const LoginFailure('Không thể đăng nhập. Vui lòng thử lại.'));
    }
  }

  Future<void> _onRegisterRequest(
      RegisterRequest event,
      Emitter<LoginState> emit
  ) async {
    emit(const Register());
  }
  
}