import '../entities/nutrition_entity.dart';

class NutritionModel extends NutritionEntity {
  const NutritionModel({
    required super.bmr,
    required super.tdee,
    required super.maintainCalories,
    required super.loseCalories,
    required super.gainCalories,
    required super.dailyProtein,
    required super.dailyCarbs,
    required super.dailyFat,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      bmr: (json['bmr'] as num).toDouble(),
      tdee: (json['tdee'] as num).toDouble(),
      maintainCalories: (json['maintainCalories'] as num).toDouble(),
      loseCalories: (json['loseCalories'] as num).toDouble(),
      gainCalories: (json['gainCalories'] as num).toDouble(),
      dailyProtein: (json['dailyProtein'] as num).toDouble(),
      dailyCarbs: (json['dailyCarbs'] as num).toDouble(),
      dailyFat: (json['dailyFat'] as num).toDouble(),
    );
  }
}
