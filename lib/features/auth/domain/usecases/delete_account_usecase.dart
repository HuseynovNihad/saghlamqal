import '../repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final IAuthRepository _repository;

  const DeleteAccountUseCase(this._repository);

  Future<void> call() => _repository.deleteAccount();
}
