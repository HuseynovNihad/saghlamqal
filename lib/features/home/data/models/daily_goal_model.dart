import 'macro_model.dart';

class DailyGoalModel {
  final int dailyKcal;
  final MacroModel protein;
  final MacroModel carbs;
  final MacroModel fats;

  const DailyGoalModel({
    required this.dailyKcal,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory DailyGoalModel.fromJson(Map<String, dynamic> json) {
    return DailyGoalModel(
      dailyKcal: json['daily_kcal'] as int,
      protein: MacroModel.fromJson(json['protein'] as Map<String, dynamic>),
      carbs: MacroModel.fromJson(json['carbs'] as Map<String, dynamic>),
      fats: MacroModel.fromJson(json['fats'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily_kcal': dailyKcal,
      'protein': protein.toJson(),
      'carbs': carbs.toJson(),
      'fats': fats.toJson(),
    };
  }
}
