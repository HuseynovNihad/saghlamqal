import '../../data/models/request/complete_profile_request.dart';
import '../../data/models/request/register_request.dart';
import '../../data/models/response/user_model.dart';

import '../entities/auth_response_entity.dart';
import '../entities/register_response_entity.dart';
import '../entities/verify_otp_response_entity.dart';

abstract class IAuthRepository {
  Future<AuthResponseEntity> login(String email, String password);

  Future<AuthResponseEntity> loginWithToken(String token);

  Future<AuthResponseEntity> googleLogin(String idToken);

  Future<RegisterResponseEntity> register(RegisterRequest request);

  Future<UserModel> completeProfile(CompleteProfileRequest request);

  Future<VerifyOtpResponseEntity> verifyOtp({
    required String email,
    required String otp,
  });

  Future<void> resendOtp(String email);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> logout(String refreshToken);

  Future<void> deleteAccount();

  Future<void> requestRestoreAccount(String email);

  Future<AuthResponseEntity> verifyRestoreAccount({
    required String email,
    required String otp,
  });
}
