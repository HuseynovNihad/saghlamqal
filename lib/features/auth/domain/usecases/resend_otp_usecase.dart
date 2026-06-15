import '../repositories/auth_repository.dart';

class ResendOtpUsecase {
  final IAuthRepository _repository;

  const ResendOtpUsecase(this._repository);

  Future<void> call(String email) => _repository.resendOtp(email);
}
