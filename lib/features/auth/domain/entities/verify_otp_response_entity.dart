import '../../../../shared/entities/nutrition_entity.dart';
import 'user_entity.dart';

class VerifyOtpResponseEntity {
  final String token;
  final String refreshToken;
  final UserEntity user;
  final NutritionEntity nutrition;

  const VerifyOtpResponseEntity({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.nutrition,
  });
}
