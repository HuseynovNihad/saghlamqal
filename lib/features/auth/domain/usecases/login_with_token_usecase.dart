import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithTokenUsecase {
  final IAuthRepository _repository;

  const LoginWithTokenUsecase(this._repository);

  Future<AuthResponseEntity> call(String token) =>
      _repository.loginWithToken(token);
}
