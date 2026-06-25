import '../repositories/auth_repository.dart';

class RequestRestoreAccountUsecase {
  final IAuthRepository _repository;

  const RequestRestoreAccountUsecase(this._repository);

  Future<void> call(String email) => _repository.requestRestoreAccount(email);
}
