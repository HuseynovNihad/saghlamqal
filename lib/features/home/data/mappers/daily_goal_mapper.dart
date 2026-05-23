import '../../domain/entities/daily_goal_entity.dart';
import '../models/daily_goal_model.dart';
import 'macro_mapper.dart';

class DailyGoalMapper {
  const DailyGoalMapper._();

  static DailyGoalEntity toEntity(DailyGoalModel model) {
    return DailyGoalEntity(
      dailyKcal: model.dailyKcal,
      protein: macroToEntity(model.protein),
      carbs: macroToEntity(model.carbs),
      fats: macroToEntity(model.fats),
    );
  }

  static DailyGoalModel toModel(DailyGoalEntity entity) {
    return DailyGoalModel(
      dailyKcal: entity.dailyKcal,
      protein: macroToModel(entity.protein),
      carbs: macroToModel(entity.carbs),
      fats: macroToModel(entity.fats),
    );
  }
}
