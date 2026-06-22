import '../../domain/entities/daily_goal_entity.dart';
import '../models/daily_goal_model.dart';

class DailyGoalMapper {
  const DailyGoalMapper._();

  static DailyGoalEntity toEntity(DailyGoalModel model) {
    return DailyGoalEntity(
      id: model.id,
      bmr: model.bmr,
      tdee: model.tdee,
      maintainCalories: model.maintainCalories,
      loseCalories: model.loseCalories,
      gainCalories: model.gainCalories,
      dailyProtein: model.dailyProtein,
      dailyCarbs: model.dailyCarbs,
      dailyFat: model.dailyFat,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static DailyGoalModel toModel(DailyGoalEntity entity) {
    return DailyGoalModel(
      id: entity.id,
      bmr: entity.bmr,
      tdee: entity.tdee,
      maintainCalories: entity.maintainCalories,
      loseCalories: entity.loseCalories,
      gainCalories: entity.gainCalories,
      dailyProtein: entity.dailyProtein,
      dailyCarbs: entity.dailyCarbs,
      dailyFat: entity.dailyFat,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
