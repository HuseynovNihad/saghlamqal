import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyRestoreAccountUsecase {
  final IAuthRepository _repository;

  const VerifyRestoreAccountUsecase(this._repository);

  Future<AuthResponseEntity> call({
    required String email,
    required String otp,
  }) => _repository.verifyRestoreAccount(email: email, otp: otp);
}
