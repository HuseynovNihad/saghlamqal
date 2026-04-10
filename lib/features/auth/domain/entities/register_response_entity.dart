import 'user_entity.dart';

class RegisterResponseEntity {
  final UserEntity user;
  final String token;
  final double bmr;
  final double tdee;
  final double maintainCalories;
  final double loseCalories;
  final double gainCalories;

  const RegisterResponseEntity({
    required this.user,
    required this.token,
    required this.bmr,
    required this.tdee,
    required this.maintainCalories,
    required this.loseCalories,
    required this.gainCalories,
  });
}
