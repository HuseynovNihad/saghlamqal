import '../../domain/entities/favorite_item_entity.dart';
import '../../domain/entities/favorite_collection_entity.dart';
import '../models/favorite_item_model.dart';
import '../models/favorite_collection_model.dart';

class FavoriteMapper {
  static FavoriteItemEntity toEntity(FavoriteItemModel model) {
    return FavoriteItemEntity(
      id: model.id,
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

  static FavoriteItemModel toModel(FavoriteItemEntity entity) {
    return FavoriteItemModel(
      id: entity.id,
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

  static List<FavoriteItemEntity> toEntityList(
    List<FavoriteItemModel> models,
  ) => models.map(toEntity).toList();

  static FavoriteCollectionEntity toCollectionEntity(
    FavoriteCollectionModel model, {
    int itemCount = 0,
  }) {
    return FavoriteCollectionEntity(
      id: model.id,
      name: model.name,
      icon: model.icon,
      description: model.description,
      itemCount: itemCount,
      createdAt: DateTime.parse(model.createdAt),
    );
  }

  static FavoriteCollectionModel toCollectionModel(
    FavoriteCollectionEntity entity,
  ) {
    return FavoriteCollectionModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      description: entity.description,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }
}
