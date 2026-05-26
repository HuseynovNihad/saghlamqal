import '../../data/models/photo_product_model.dart';
import '../../domain/entities/photo_product_entity.dart';

class PhotoProductMapper {
  static PhotoProductEntity toEntity(PhotoProductModel model) {
    return PhotoProductEntity(
      name: model.name,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      vitamins: model.vitamins,
      advice: model.advice,
      isFood: model.isFood,
    );
  }

  static PhotoProductModel toModel(PhotoProductEntity entity) {
    return PhotoProductModel(
      name: entity.name,
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
