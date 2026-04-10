abstract class AuthEvent {
  const AuthEvent();
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
}

class AppStarted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
