import '../../../../shared/entities/nutrition_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final String token;

  const AuthAuthenticated({required this.user, required this.token});
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthRegistered extends AuthState {
  final String email;
  const AuthRegistered({required this.email});
}

class AuthOtpVerified extends AuthState {
  final UserEntity user;
  final String token;
  final NutritionEntity nutrition;

  const AuthOtpVerified({
    required this.user,
    required this.token,
    required this.nutrition,
  });
}

class AuthOtpResent extends AuthState {
  const AuthOtpResent();
}

class AuthForgotPasswordSent extends AuthState {
  final String email;
  const AuthForgotPasswordSent({required this.email});
}

class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess();
}

class AuthSessionLoading extends AuthState {
  const AuthSessionLoading();
}

class AuthAccountDeleted extends AuthState {
  const AuthAccountDeleted();
}

class AuthAccountDeactivated extends AuthState {
  final String email;
  const AuthAccountDeactivated({required this.email});
}

class AuthRestoreOtpSent extends AuthState {
  final String email;
  const AuthRestoreOtpSent({required this.email});
}
