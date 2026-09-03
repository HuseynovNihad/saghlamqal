import '../../domain/entities/user_entity.dart';

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

// ─────────────────────────────────────────────────────────────
// LOGIN
// ─────────────────────────────────────────────────────────────

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
}

// ─────────────────────────────────────────────────────────────
// GOOGLE LOGIN
// ─────────────────────────────────────────────────────────────

class GoogleLoginSubmitted extends AuthEvent {
  final String idToken;

  const GoogleLoginSubmitted({required this.idToken});
}

// ─────────────────────────────────────────────────────────────
// REGISTER
// ─────────────────────────────────────────────────────────────

class RegisterSubmitted extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;

  const RegisterSubmitted({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
  });
}

// ─────────────────────────────────────────────────────────────
// COMPLETE PROFILE
// ─────────────────────────────────────────────────────────────

class CompleteProfileSubmitted extends AuthEvent {
  final String phoneNumber;
  final DateTime birthday;
  final String gender;
  final double height;
  final double currentWeight;
  final double? targetWeight;
  final String activityLevel;
  final String goal;

  const CompleteProfileSubmitted({
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    required this.height,
    required this.currentWeight,
    this.targetWeight,
    required this.activityLevel,
    required this.goal,
  });
}

// ─────────────────────────────────────────────────────────────
// VERIFY OTP
// ─────────────────────────────────────────────────────────────

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
  final String confirmPassword;

  const ResetPasswordSubmitted({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class ReactivateAccountRequested extends AuthEvent {
  final String email;

  const ReactivateAccountRequested({required this.email});
}

class VerifyRestoreAccountSubmitted extends AuthEvent {
  final String email;
  final String otp;

  const VerifyRestoreAccountSubmitted({required this.email, required this.otp});
}

class AuthUserUpdated extends AuthEvent {
  final UserEntity user;

  const AuthUserUpdated(this.user);
}
