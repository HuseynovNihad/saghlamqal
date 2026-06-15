import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final IAuthRepository _repository;

  const LoginUsecase(this._repository);

  Future<AuthResponseEntity> call({
    required String email,
    required String password,
  }) => _repository.login(email, password);
}
