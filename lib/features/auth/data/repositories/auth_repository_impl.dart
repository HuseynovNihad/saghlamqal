import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/register_response_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<AuthResponseEntity> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _remoteDataSource.login(request);

    return AuthResponseEntity(user: response.user, token: response.token);
  }

  @override
  Future<AuthResponseEntity> loginWithToken(String token) async {
    final response = await _remoteDataSource.getMe(token);

    return AuthResponseEntity(user: response.user, token: token);
  }

  @override
  Future<RegisterResponseEntity> register(RegisterRequest request) async {
    final response = await _remoteDataSource.register(request);

    return RegisterResponseEntity(
      user: response.user,
      token: response.token,
      bmr: response.bmr,
      tdee: response.tdee,
      maintainCalories: response.maintainCalories,
      loseCalories: response.loseCalories,
      gainCalories: response.gainCalories,
    );
  }
}
