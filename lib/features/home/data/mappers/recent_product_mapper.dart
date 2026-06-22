import '../../domain/entities/recent_product_entity.dart';
import '../models/recent_product_model.dart';

class RecentProductMapper {
  const RecentProductMapper._();

  static RecentProductEntity toEntity(RecentProductModel model) {
    return RecentProductEntity(
      id: model.id,
      icon: model.icon,
      name: model.name,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      vitamins: model.vitamins,
      advice: model.advice,
      isFood: model.isFood,
      servingSize: model.servingSize,
      servingUnit: model.servingUnit,
      createdAt: DateTime.parse(model.createdAt),
    );
  }

  static RecentProductModel toModel(RecentProductEntity entity) {
    return RecentProductModel(
      id: entity.id,
      icon: entity.icon,
      name: entity.name,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      vitamins: entity.vitamins,
      advice: entity.advice,
      isFood: entity.isFood,
      servingSize: entity.servingSize,
      servingUnit: entity.servingUnit,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }
}
