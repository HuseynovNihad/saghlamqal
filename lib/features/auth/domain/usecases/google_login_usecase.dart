import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class GoogleLoginUsecase {
  final IAuthRepository _repository;

  const GoogleLoginUsecase(this._repository);

  Future<AuthResponseEntity> call(String idToken) {
    return _repository.googleLogin(idToken);
  }
}