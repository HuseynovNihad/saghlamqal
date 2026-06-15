import '../repositories/auth_repository.dart';

class ForgotPasswordUsecase {
  final IAuthRepository _repository;

  const ForgotPasswordUsecase(this._repository);

  Future<void> call(String email) => _repository.forgotPassword(email);
}