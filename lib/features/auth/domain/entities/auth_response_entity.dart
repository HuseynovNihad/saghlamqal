import '../../../../shared/entities/nutrition_entity.dart';
import 'user_entity.dart';

class AuthResponseEntity {
  final UserEntity user;
  final String token;
  final String refreshToken;
  final NutritionEntity? nutrition;

  AuthResponseEntity({
    required this.user,
    required this.token,
    required this.refreshToken,
    this.nutrition,
  });
}
