import '../repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final IAuthRepository _repository;

  const ResetPasswordUsecase(this._repository);

  Future<void> call({
    required String email,
    required String otp,
    required String newPassword,
  }) => _repository.resetPassword(
    email: email,
    otp: otp,
    newPassword: newPassword,
  );
}
