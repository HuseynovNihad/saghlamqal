import '../../../domain/entities/register_response_entity.dart';
import 'user_model.dart';

class RegisterResponseModel extends RegisterResponseEntity {
  RegisterResponseModel({
    required super.user,
    required super.token,
    required super.bmr,
    required super.tdee,
    required super.maintainCalories,
    required super.loseCalories,
    required super.gainCalories,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],

      bmr: (json['nutrition']['bmr'] as num).toDouble(),
      tdee: (json['nutrition']['tdee'] as num).toDouble(),
      maintainCalories: (json['nutrition']['maintainCalories'] as num)
          .toDouble(),
      loseCalories: (json['nutrition']['loseCalories'] as num).toDouble(),
      gainCalories: (json['nutrition']['gainCalories'] as num).toDouble(),
    );
  }
}
