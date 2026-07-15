import '../../data/models/request/register_request.dart';
import '../entities/register_response_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final IAuthRepository _repository;

  const RegisterUsecase(this._repository);

  Future<RegisterResponseEntity> call(RegisterRequest request) =>
      _repository.register(request);
}
