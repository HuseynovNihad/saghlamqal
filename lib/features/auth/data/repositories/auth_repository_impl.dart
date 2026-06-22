import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/register_response_entity.dart';
import '../../domain/entities/verify_otp_response_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/request/verify_otp_request.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

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

  @override
  Future<RegisterResponseEntity> register(RegisterRequest request) async {
    final response = await _remoteDataSource.register(request);
    return RegisterResponseEntity(message: response.message);
  }

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

  @override
  Future<void> resendOtp(String email) async {
    await _remoteDataSource.resendOtp(email);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _remoteDataSource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await _remoteDataSource.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout(String refreshToken) async {
    await _remoteDataSource.logout(refreshToken);
  }
}
