abstract class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
}

class RegisterSubmitted extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final int age;
  final double weight;
  final double height;
  final String gender;
  final String activityLevel;
  final String password;
  final String confirmPassword;

  const RegisterSubmitted({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.activityLevel,
    required this.password,
    required this.confirmPassword,
  });
}
