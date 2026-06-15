// domain/usecases/verify_otp_usecase.dart
import '../entities/verify_otp_response_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final IAuthRepository _repository;

  const VerifyOtpUsecase(this._repository);

  Future<VerifyOtpResponseEntity> call({
    required String email,
    required String otp,
  }) => _repository.verifyOtp(email: email, otp: otp);
}
