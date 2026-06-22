class DailyGoalModel {
  final String id;
  final double bmr;
  final double tdee;
  final double maintainCalories;
  final double loseCalories;
  final double gainCalories;
  final double dailyProtein;
  final double dailyCarbs;
  final double dailyFat;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DailyGoalModel({
    required this.id,
    required this.bmr,
    required this.tdee,
    required this.maintainCalories,
    required this.loseCalories,
    required this.gainCalories,
    required this.dailyProtein,
    required this.dailyCarbs,
    required this.dailyFat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyGoalModel.fromJson(Map<String, dynamic> json) {
    return DailyGoalModel(
      id: json['id'] as String,
      bmr: (json['bmr'] as num).toDouble(),
      tdee: (json['tdee'] as num).toDouble(),
      maintainCalories: (json['maintainCalories'] as num).toDouble(),
      loseCalories: (json['loseCalories'] as num).toDouble(),
      gainCalories: (json['gainCalories'] as num).toDouble(),
      dailyProtein: (json['dailyProtein'] as num).toDouble(),
      dailyCarbs: (json['dailyCarbs'] as num).toDouble(),
      dailyFat: (json['dailyFat'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bmr': bmr,
      'tdee': tdee,
      'maintainCalories': maintainCalories,
      'loseCalories': loseCalories,
      'gainCalories': gainCalories,
      'dailyProtein': dailyProtein,
      'dailyCarbs': dailyCarbs,
      'dailyFat': dailyFat,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
