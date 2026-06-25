import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/request/verify_otp_request.dart';
import '../models/response/login_response_model.dart';
import '../models/response/register_response_model.dart';
import '../models/response/user_model.dart';
import '../models/response/verify_otp_response_model.dart';

abstract class IAuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequest request);
  Future<RegisterResponseModel> register(RegisterRequest request);
  Future<UserModel> getMe();
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequest request);
  Future<void> resendOtp(String email);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
  Future<void> logout(String refreshToken);
  Future<void> deleteAccount();
  Future<void> requestRestoreAccount(String email);
  Future<LoginResponseModel> verifyRestoreAccount({
    required String email,
    required String otp,
  });
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final NetworkManager _networkManager;

  AuthRemoteDataSourceImpl(this._networkManager);

  @override
  Future<LoginResponseModel> login(LoginRequest request) async {
    final response = await _networkManager.post(
      Endpoints.login,
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequest request) async {
    final response = await _networkManager.post(
      Endpoints.register,
      data: request.toJson(),
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getMe() async {
    final response = await _networkManager.get(Endpoints.getMe);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequest request) async {
    final response = await _networkManager.post(
      Endpoints.verifyOtp,
      data: request.toJson(),
    );
    return VerifyOtpResponseModel.fromJson(response.data);
  }

  @override
  Future<void> resendOtp(String email) async {
    await _networkManager.post(Endpoints.resendOtp, data: {'email': email});
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _networkManager.post(
      Endpoints.forgotPassword,
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await _networkManager.post(
      Endpoints.resetPassword,
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
  }

  @override
  Future<void> logout(String refreshToken) async {
    await _networkManager.post(
      Endpoints.logout,
      data: {'refreshToken': refreshToken},
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _networkManager.delete(Endpoints.deleteAccount);
  }

  @override
  Future<void> requestRestoreAccount(String email) async {
    await _networkManager.post(
      Endpoints.restoreAccountRequest,
      data: {'email': email},
    );
  }

  @override
  Future<LoginResponseModel> verifyRestoreAccount({
    required String email,
    required String otp,
  }) async {
    final response = await _networkManager.post(
      Endpoints.restoreAccountVerify,
      data: {'email': email, 'otp': otp},
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
