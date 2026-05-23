import 'package:equatable/equatable.dart';

import 'macro_entity.dart';

class DailyGoalEntity extends Equatable {
  final int dailyKcal;
  final MacroEntity protein;
  final MacroEntity carbs;
  final MacroEntity fats;

  const DailyGoalEntity({
    required this.dailyKcal,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  @override
  List<Object?> get props => [dailyKcal, protein, carbs, fats];
}
