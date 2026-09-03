import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/network/models/network_exceptions.dart';
import '../../../../core/storage/token_storage.dart';

import '../../data/models/request/complete_profile_request.dart';
import '../../data/models/request/register_request.dart';

import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/google_login_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/login_with_token_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/request_restore_account_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/verify_restore_account_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _login;
  final GoogleLoginUsecase _googleLogin;
  final LoginWithTokenUsecase _loginWithToken;
  final RegisterUsecase _register;
  final CompleteProfileUsecase _completeProfile;
  final VerifyOtpUsecase _verifyOtp;
  final ResendOtpUsecase _resendOtp;
  final ForgotPasswordUsecase _forgotPassword;
  final ResetPasswordUsecase _resetPassword;
  final LogoutUsecase _logout;
  final DeleteAccountUseCase _deleteAccount;
  final RequestRestoreAccountUsecase _requestRestoreAccount;
  final VerifyRestoreAccountUsecase _verifyRestoreAccount;

  AuthBloc({
    required LoginUsecase login,
    required GoogleLoginUsecase googleLogin,
    required LoginWithTokenUsecase loginWithToken,
    required RegisterUsecase register,
    required CompleteProfileUsecase completeProfile,
    required VerifyOtpUsecase verifyOtp,
    required ResendOtpUsecase resendOtp,
    required ForgotPasswordUsecase forgotPassword,
    required ResetPasswordUsecase resetPassword,
    required LogoutUsecase logout,
    required DeleteAccountUseCase deleteAccount,
    required RequestRestoreAccountUsecase requestRestoreAccount,
    required VerifyRestoreAccountUsecase verifyRestoreAccount,
  }) : _login = login,
       _googleLogin = googleLogin,
       _loginWithToken = loginWithToken,
       _register = register,
       _completeProfile = completeProfile,
       _verifyOtp = verifyOtp,
       _resendOtp = resendOtp,
       _forgotPassword = forgotPassword,
       _resetPassword = resetPassword,
       _logout = logout,
       _deleteAccount = deleteAccount,
       _requestRestoreAccount = requestRestoreAccount,
       _verifyRestoreAccount = verifyRestoreAccount,
       super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);

    on<LoginSubmitted>(_onLogin);
    on<GoogleLoginSubmitted>(_onGoogleLogin);

    on<RegisterSubmitted>(_onRegister);
    on<CompleteProfileSubmitted>(_onCompleteProfile);

    on<VerifyOtpSubmitted>(_onVerifyOtp);
    on<ResendOtpSubmitted>(_onResendOtp);

    on<ForgotPasswordSubmitted>(_onForgotPassword);
    on<ResetPasswordSubmitted>(_onResetPassword);

    on<LogoutRequested>(_onLogout);

    on<AuthStateReset>(_onAuthStateReset);

    on<DeleteAccountRequested>(_onDeleteAccount);

    on<ReactivateAccountRequested>(_onReactivateAccount);
    on<VerifyRestoreAccountSubmitted>(_onVerifyRestoreAccount);

    on<AuthUserUpdated>(_onAuthUserUpdated);
  }

  // ─────────────────────────────────────────────────────────────
  // ERROR HANDLING
  // ─────────────────────────────────────────────────────────────

  String _mapError(Object e) {
    final result = _resolveErrorMessage(e);

    log(
      '[AuthBloc] Səhifəyə göstərilən xəta: '
      '"$result" | Original error: $e',
    );

    return result;
  }

  String _resolveErrorMessage(Object e) {
    if (e is AppException) {
      return e.message;
    }

    if (e is TypeError ||
        e is FormatException ||
        e.toString().contains('is not a subtype') ||
        e.toString().contains('type ')) {
      return 'Xəta baş verdi, yenidən cəhd edin';
    }

    final message = e.toString();

    if (message.length > 150 || message.contains('Exception:')) {
      return 'Xəta baş verdi, yenidən cəhd edin';
    }

    return message;
  }

  // ─────────────────────────────────────────────────────────────
  // APP START
  // ─────────────────────────────────────────────────────────────

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthSessionLoading());

    await Future.delayed(const Duration(seconds: 3));

    final token = sl<TokenStorage>().getToken();

    if (token == null || token.isEmpty) {
      emit(const AuthUnauthenticated());
      return;
    }

    try {
      final response = await _loginWithToken(token);

      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      log('Session restore failed: $e');

      emit(const AuthUnauthenticated());
    }
  }

  // ─────────────────────────────────────────────────────────────
  // LOGIN
  // ─────────────────────────────────────────────────────────────

  Future<void> _onLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final response = await _login(
        email: event.email,
        password: event.password,
      );

      if (!response.user.isActive) {
        emit(AuthAccountDeactivated(email: event.email));
        return;
      }

      await sl<TokenStorage>().saveToken(response.token);
      await sl<TokenStorage>().saveRefreshToken(response.refreshToken);

      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      final emailNotVerified = _extractEmailNotVerified(e);

      if (emailNotVerified != null) {
        emit(AuthEmailNotVerified(email: emailNotVerified));
        return;
      }

      final passwordNotSetEmail = _extractPasswordNotSet(e);

      if (passwordNotSetEmail != null) {
        emit(AuthPasswordNotSet(email: passwordNotSetEmail));
        return;
      }

      emit(AuthError(_mapError(e)));
    }
  }

  String? _extractEmailNotVerified(Object e) {
    if (e is! AppException) {
      return null;
    }

    if (e.errorCode != 'EMAIL_NOT_VERIFIED') {
      return null;
    }

    return e.extra?['email']?.toString() ?? '';
  }

  String? _extractPasswordNotSet(Object e) {
    if (e is! AppException) {
      return null;
    }

    if (e.errorCode != 'PASSWORD_NOT_SET') {
      return null;
    }

    return e.extra?['email']?.toString();
  }

  // ─────────────────────────────────────────────────────────────
  // GOOGLE LOGIN
  // ─────────────────────────────────────────────────────────────

  Future<void> _onGoogleLogin(
    GoogleLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _googleLogin(event.idToken);

      if (!response.user.isActive) {
        emit(AuthAccountDeactivated(email: response.user.email));

        return;
      }

      await sl<TokenStorage>().saveToken(response.token);

      await sl<TokenStorage>().saveRefreshToken(response.refreshToken);

      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // REGISTER
  // ─────────────────────────────────────────────────────────────

  Future<void> _onRegister(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _register(
        RegisterRequest(
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          password: event.password,
          confirmPassword: event.confirmPassword,
        ),
      );

      emit(AuthRegistered(email: event.email));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // COMPLETE PROFILE
  // ─────────────────────────────────────────────────────────────

  Future<void> _onCompleteProfile(
    CompleteProfileSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _completeProfile(
        CompleteProfileRequest(
          phoneNumber: event.phoneNumber,
          birthday: event.birthday,
          gender: event.gender,
          height: event.height,
          currentWeight: event.currentWeight,
          targetWeight: event.targetWeight,
          activityLevel: event.activityLevel,
          goal: event.goal,
        ),
      );

      final token = sl<TokenStorage>().getToken();

      if (token == null || token.isEmpty) {
        emit(const AuthUnauthenticated());

        return;
      }

      emit(AuthAuthenticated(user: user, token: token));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // VERIFY OTP
  // ─────────────────────────────────────────────────────────────

  Future<void> _onVerifyOtp(
    VerifyOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _verifyOtp(email: event.email, otp: event.otp);

      await sl<TokenStorage>().saveToken(response.token);

      await sl<TokenStorage>().saveRefreshToken(response.refreshToken);

      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // RESEND OTP
  // ─────────────────────────────────────────────────────────────

  Future<void> _onResendOtp(
    ResendOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    log('[AuthBloc] RESEND OTP | start, email: ${event.email}');

    emit(const AuthLoading());

    try {
      await _resendOtp(event.email);

      log('[AuthBloc] RESEND OTP | success');

      emit(const AuthOtpResent());
    } catch (e) {
      log(
        '[AuthBloc] RESEND OTP | error: '
        '$e | type: ${e.runtimeType}',
      );

      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // FORGOT PASSWORD
  // ─────────────────────────────────────────────────────────────

  Future<void> _onForgotPassword(
    ForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _forgotPassword(event.email);

      emit(AuthForgotPasswordSent(email: event.email));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // RESET PASSWORD
  // ─────────────────────────────────────────────────────────────

  Future<void> _onResetPassword(
    ResetPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _resetPassword(
        email: event.email,
        otp: event.otp,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );

      emit(const AuthPasswordResetSuccess());
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // LOGOUT
  // ─────────────────────────────────────────────────────────────

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      final refreshToken = sl<TokenStorage>().getRefreshToken();

      if (refreshToken != null) {
        await _logout(refreshToken);
      }

      await sl<TokenStorage>().clearAll();

      emit(const AuthUnauthenticated());
    } catch (e) {
      await sl<TokenStorage>().clearAll();

      emit(const AuthUnauthenticated());
    }
  }

  // ─────────────────────────────────────────────────────────────
  // RESET STATE
  // ─────────────────────────────────────────────────────────────

  void _onAuthStateReset(AuthStateReset event, Emitter<AuthState> emit) {
    emit(const AuthUnauthenticated());
  }

  // ─────────────────────────────────────────────────────────────
  // DELETE ACCOUNT
  // ─────────────────────────────────────────────────────────────

  Future<void> _onDeleteAccount(
    DeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _deleteAccount();

      await sl<TokenStorage>().clearAll();

      emit(const AuthAccountDeleted());
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // REACTIVATE ACCOUNT
  // ─────────────────────────────────────────────────────────────

  Future<void> _onReactivateAccount(
    ReactivateAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _requestRestoreAccount(event.email);

      emit(AuthRestoreOtpSent(email: event.email));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // VERIFY RESTORE ACCOUNT
  // ─────────────────────────────────────────────────────────────

  Future<void> _onVerifyRestoreAccount(
    VerifyRestoreAccountSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final response = await _verifyRestoreAccount(
        email: event.email,
        otp: event.otp,
      );

      await sl<TokenStorage>().saveToken(response.token);

      await sl<TokenStorage>().saveRefreshToken(response.refreshToken);

      emit(AuthAuthenticated(user: response.user, token: response.token));
    } catch (e) {
      emit(AuthError(_mapError(e)));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // UPDATE AUTH USER
  // ─────────────────────────────────────────────────────────────

  void _onAuthUserUpdated(AuthUserUpdated event, Emitter<AuthState> emit) {
    final currentState = state;

    if (currentState is AuthAuthenticated) {
      emit(AuthAuthenticated(user: event.user, token: currentState.token));
    }
  }
}
