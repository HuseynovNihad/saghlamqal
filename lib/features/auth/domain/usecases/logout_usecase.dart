import '../repositories/auth_repository.dart';

class LogoutUsecase {
  final IAuthRepository _repository;

  LogoutUsecase(this._repository);

  Future<void> call(String refreshToken) async {
    await _repository.logout(refreshToken);
  }
}
