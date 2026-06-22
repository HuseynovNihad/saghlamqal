import 'package:equatable/equatable.dart';

class DailyGoalEntity extends Equatable {
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

  const DailyGoalEntity({
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

  factory DailyGoalEntity.empty() {
    final now = DateTime.now();

    return DailyGoalEntity(
      id: '',
      bmr: 0,
      tdee: 0,
      maintainCalories: 0,
      loseCalories: 0,
      gainCalories: 0,
      dailyProtein: 0,
      dailyCarbs: 0,
      dailyFat: 0,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  List<Object?> get props => [
    id,
    bmr,
    tdee,
    maintainCalories,
    loseCalories,
    gainCalories,
    dailyProtein,
    dailyCarbs,
    dailyFat,
    createdAt,
    updatedAt,
  ];
}
