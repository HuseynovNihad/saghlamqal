import '../../../domain/entities/auth_response_entity.dart';
import 'user_model.dart';

class LoginResponseModel extends AuthResponseEntity {
  LoginResponseModel({required super.user, required super.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}
