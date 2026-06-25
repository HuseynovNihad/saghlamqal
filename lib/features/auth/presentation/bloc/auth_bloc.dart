import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/models/request/register_request.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/login_with_token_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/request_restore_account_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_restore_account_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _login;
  final LoginWithTokenUsecase _loginWithToken;
  final RegisterUsecase _register;
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
    required LoginWithTokenUsecase loginWithToken,
    required RegisterUsecase register,
    required VerifyOtpUsecase verifyOtp,
    required ResendOtpUsecase resendOtp,
    required ForgotPasswordUsecase forgotPassword,
    required ResetPasswordUsecase resetPassword,
    required LogoutUsecase logout,
    required DeleteAccountUseCase deleteAccount,
    required RequestRestoreAccountUsecase requestRestoreAccount,
    required VerifyRestoreAccountUsecase verifyRestoreAccount,
  }) : _login = login,
       _loginWithToken = loginWithToken,
       _register = register,
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
    on<RegisterSubmitted>(_onRegister);
    on<VerifyOtpSubmitted>(_onVerifyOtp);
    on<ResendOtpSubmitted>(_onResendOtp);
    on<ForgotPasswordSubmitted>(_onForgotPassword);
    on<ResetPasswordSubmitted>(_onResetPassword);
    on<LogoutRequested>(_onLogout);
    on<AuthStateReset>(_onAuthStateReset);
    on<DeleteAccountRequested>(_onDeleteAccount);
    on<ReactivateAccountRequested>(_onReactivateAccount);
    on<VerifyRestoreAccountSubmitted>(_onVerifyRestoreAccount);
  }

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
      emit(AuthError(e.toString()));
    }
  }

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
          birthday: event.birthday,
          age: event.age,
          weight: event.weight,
          height: event.height,
          gender: event.gender,
          activityLevel: event.activityLevel,
          password: event.password,
          confirmPassword: event.confirmPassword,
        ),
      );
      emit(AuthRegistered(email: event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

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
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _resendOtp(event.email);
      emit(const AuthOtpResent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _forgotPassword(event.email);
      emit(AuthForgotPasswordSent(email: event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

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
      );
      emit(const AuthPasswordResetSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

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

  void _onAuthStateReset(AuthStateReset event, Emitter<AuthState> emit) {
    emit(const AuthUnauthenticated());
  }

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
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onReactivateAccount(
    ReactivateAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _requestRestoreAccount(event.email);
      emit(AuthRestoreOtpSent(email: event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

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
      emit(AuthError(e.toString()));
    }
  }
}
