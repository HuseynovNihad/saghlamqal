abstract class AuthEvent {
  const AuthEvent();
}

class AppStarted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class DeleteAccountRequested extends AuthEvent {
  const DeleteAccountRequested();
}

class AuthStateReset extends AuthEvent {
  const AuthStateReset();
}

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

class VerifyOtpSubmitted extends AuthEvent {
  final String email;
  final String otp;

  const VerifyOtpSubmitted({required this.email, required this.otp});
}

class ResendOtpSubmitted extends AuthEvent {
  final String email;

  const ResendOtpSubmitted({required this.email});
}

class ForgotPasswordSubmitted extends AuthEvent {
  final String email;

  const ForgotPasswordSubmitted({required this.email});
}

class ResetPasswordSubmitted extends AuthEvent {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordSubmitted({
    required this.email,
    required this.otp,
    required this.newPassword,
  });
}

// Köhnəni silin, yenisini yazın
class ReactivateAccountRequested extends AuthEvent {
  final String email;
  const ReactivateAccountRequested({required this.email});
}

class VerifyRestoreAccountSubmitted extends AuthEvent {
  final String email;
  final String otp;
  const VerifyRestoreAccountSubmitted({required this.email, required this.otp});
}
