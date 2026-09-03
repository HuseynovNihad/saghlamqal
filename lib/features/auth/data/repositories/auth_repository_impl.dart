import '../../../../core/storage/token_storage.dart';

import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/register_response_entity.dart';
import '../../domain/entities/verify_otp_response_entity.dart';
import '../../domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_datasource.dart';

import '../models/request/complete_profile_request.dart';
import '../models/request/google_login_request.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/request/verify_otp_request.dart';

import '../models/response/user_model.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  // ─────────────────────────────────────────────────────────────
  // LOGIN
  // ─────────────────────────────────────────────────────────────

  @override
  Future<AuthResponseEntity> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);

    final response = await _remoteDataSource.login(request);

    return AuthResponseEntity(
      user: response.user,
      token: response.token,
      refreshToken: response.refreshToken,
      nutrition: response.nutrition,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // GOOGLE LOGIN
  // ─────────────────────────────────────────────────────────────

  @override
  Future<AuthResponseEntity> googleLogin(String idToken) async {
    final request = GoogleLoginRequest(idToken: idToken);

    final response = await _remoteDataSource.googleLogin(request);

    return AuthResponseEntity(
      user: response.user,
      token: response.token,
      refreshToken: response.refreshToken,
      nutrition: response.nutrition,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // LOGIN WITH TOKEN
  // ─────────────────────────────────────────────────────────────

  @override
  Future<AuthResponseEntity> loginWithToken(String token) async {
    final user = await _remoteDataSource.getMe();

    return AuthResponseEntity(
      user: user,
      token: token,
      refreshToken: _tokenStorage.getRefreshToken() ?? '',
      nutrition: null,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // REGISTER
  // ─────────────────────────────────────────────────────────────

  @override
  Future<RegisterResponseEntity> register(RegisterRequest request) async {
    final response = await _remoteDataSource.register(request);

    return RegisterResponseEntity(message: response.message);
  }

  // ─────────────────────────────────────────────────────────────
  // COMPLETE PROFILE
  // ─────────────────────────────────────────────────────────────

  @override
  Future<UserModel> completeProfile(CompleteProfileRequest request) async {
    final response = await _remoteDataSource.completeProfile(request);

    return response;
  }

  // ─────────────────────────────────────────────────────────────
  // VERIFY OTP
  // ─────────────────────────────────────────────────────────────

  @override
  Future<VerifyOtpResponseEntity> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final request = VerifyOtpRequest(email: email, otp: otp);

    final response = await _remoteDataSource.verifyOtp(request);

    return VerifyOtpResponseEntity(
      token: response.token,
      refreshToken: response.refreshToken,
      user: response.user,
      nutrition: response.nutrition,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // RESEND OTP
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> resendOtp(String email) async {
    await _remoteDataSource.resendOtp(email);
  }

  // ─────────────────────────────────────────────────────────────
  // FORGOT PASSWORD
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> forgotPassword(String email) async {
    await _remoteDataSource.forgotPassword(email);
  }

  // ─────────────────────────────────────────────────────────────
  // RESET PASSWORD
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _remoteDataSource.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // LOGOUT
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> logout(String refreshToken) async {
    await _remoteDataSource.logout(refreshToken);
  }

  // ─────────────────────────────────────────────────────────────
  // DELETE ACCOUNT
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> deleteAccount() async {
    await _remoteDataSource.deleteAccount();
  }

  // ─────────────────────────────────────────────────────────────
  // RESTORE ACCOUNT REQUEST
  // ─────────────────────────────────────────────────────────────

  @override
  Future<void> requestRestoreAccount(String email) async {
    await _remoteDataSource.requestRestoreAccount(email);
  }

  // ─────────────────────────────────────────────────────────────
  // VERIFY RESTORE ACCOUNT
  // ─────────────────────────────────────────────────────────────

  @override
  Future<AuthResponseEntity> verifyRestoreAccount({
    required String email,
    required String otp,
  }) async {
    final response = await _remoteDataSource.verifyRestoreAccount(
      email: email,
      otp: otp,
    );

    return AuthResponseEntity(
      user: response.user,
      token: response.token,
      refreshToken: response.refreshToken,
      nutrition: response.nutrition,
    );
  }
}
