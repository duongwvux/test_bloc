class LoginState {
  final String message;

  const LoginState(this.message);
}

class AuthLoading extends LoginState {
  const AuthLoading() : super('');
}

class LoginFailure extends LoginState {
  const LoginFailure(super.message);
}

class Authenticated extends LoginState {
  const Authenticated() : super('');
}

class Register extends LoginState {
  const Register() : super('');
}
