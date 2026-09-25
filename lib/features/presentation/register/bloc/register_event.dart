sealed class RegisterEvent {
  const RegisterEvent();
}

class RegisterRequest extends RegisterEvent {
  final String email;
  final String password;
  const RegisterRequest({required this.email, required this.password});
}