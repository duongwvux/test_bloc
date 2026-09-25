abstract class LoginEvent {
  const LoginEvent();
}

class AuthLoginRequested extends LoginEvent {
  final String email;
  final String password;
  const AuthLoginRequested({required this.email, required this.password});
}

class RegisterRequest extends LoginEvent {
  const RegisterRequest();
}