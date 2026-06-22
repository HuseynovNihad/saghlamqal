import '../../../domain/entities/auth_response_entity.dart';
import 'user_model.dart';
import '../../../../../shared/models/nutrition_model.dart';

class LoginResponseModel extends AuthResponseEntity {
  LoginResponseModel({
    required super.user,
    required super.token,
    required super.refreshToken,
    super.nutrition,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      nutrition: json['nutrition'] != null
          ? NutritionModel.fromJson(json['nutrition'])
          : null,
    );
  }
}
