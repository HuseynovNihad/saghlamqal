import '../../domain/entities/recent_product_entity.dart';
import '../models/recent_product_model.dart';

class RecentProductMapper {
  const RecentProductMapper._();

  static RecentProductEntity toEntity(RecentProductModel model) {
    return RecentProductEntity(
      name: model.name,
      imageUrl: model.imageUrl,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      vitamins: model.vitamins,
      advice: model.advice,
      isFood: model.isFood,
    );
  }

  static RecentProductModel toModel(RecentProductEntity entity) {
    return RecentProductModel(
      name: entity.name,
      imageUrl: entity.imageUrl,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      vitamins: entity.vitamins,
      advice: entity.advice,
      isFood: entity.isFood,
    );
  }
}
