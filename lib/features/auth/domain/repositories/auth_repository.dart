import '../../data/models/request/register_request.dart';
import '../entities/auth_response_entity.dart';
import '../entities/register_response_entity.dart';

abstract class IAuthRepository {
  Future<AuthResponseEntity> login(String email, String password);

  Future<AuthResponseEntity> loginWithToken(String token);

  Future<RegisterResponseEntity> register(RegisterRequest request);
}
