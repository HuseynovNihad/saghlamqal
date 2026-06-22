import '../../domain/entities/hydration_entity.dart';
import '../models/hydration_model.dart';

class HydrationMapper {
  const HydrationMapper._();

  static HydrationEntity toEntity(HydrationModel model) {
    return HydrationEntity(
      dailyGoal: model.dailyGoal,
      consumed: model.consumed,
      remaining: model.remaining,
      percentage: model.percentage,
    );
  }

  static HydrationModel toModel(HydrationEntity entity) {
    return HydrationModel(
      dailyGoal: entity.dailyGoal,
      consumed: entity.consumed,
      remaining: entity.remaining,
      percentage: entity.percentage,
    );
  }
}
