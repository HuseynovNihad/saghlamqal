import '../../domain/entities/hydration_entity.dart';
import '../models/hydration_model.dart';

class HydrationMapper {
  const HydrationMapper._();

  static HydrationEntity toEntity(HydrationModel model) {
    return HydrationEntity(
      tracked: model.tracked,
      recommended: model.recommended,
      addAmount: model.addAmount,
    );
  }

  static HydrationModel toModel(HydrationEntity entity) {
    return HydrationModel(
      tracked: entity.tracked,
      recommended: entity.recommended,
      addAmount: entity.addAmount,
    );
  }
}
