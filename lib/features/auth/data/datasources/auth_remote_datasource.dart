import '../../../../core/network/network_manager.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/response/login_response_model.dart';
import '../models/response/register_response_model.dart';

abstract class IAuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequest request);

  Future<RegisterResponseModel> register(RegisterRequest request);

  Future<LoginResponseModel> getMe(String token);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final NetworkManager _networkManager;

  AuthRemoteDataSourceImpl(this._networkManager);

  @override
  Future<LoginResponseModel> login(LoginRequest request) async {
    final response = await _networkManager.post(
      'auth/login',
      data: request.toJson(),
    );

    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequest request) async {
    final response = await _networkManager.post(
      'auth/register',
      data: request.toJson(),
    );

    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<LoginResponseModel> getMe(String token) async {
    final response = await _networkManager.get('auth/me');

    return LoginResponseModel.fromJson(response.data);
  }
}
