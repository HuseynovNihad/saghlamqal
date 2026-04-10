import '../../../../core/network/network_manager.dart';
import '../models/request/login_request.dart';
import '../models/response/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<UserModel> login(LoginRequest request);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final NetworkManager _networkManager;

  AuthRemoteDataSourceImpl(this._networkManager);

  @override
  Future<UserModel> login(LoginRequest request) async {
    final response = await _networkManager.post(
      'auth/login',
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data['user']);
  }
}
