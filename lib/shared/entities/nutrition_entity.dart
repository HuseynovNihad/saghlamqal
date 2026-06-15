class NutritionEntity {
  final double bmr;
  final double tdee;
  final double maintainCalories;
  final double loseCalories;
  final double gainCalories;
  final double dailyProtein;
  final double dailyCarbs;
  final double dailyFat;

  const NutritionEntity({
    required this.bmr,
    required this.tdee,
    required this.maintainCalories,
    required this.loseCalories,
    required this.gainCalories,
    required this.dailyProtein,
    required this.dailyCarbs,
    required this.dailyFat,
  });
}
