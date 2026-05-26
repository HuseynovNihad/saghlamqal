import '../../domain/entities/favorite_item_entity.dart';
import '../../domain/entities/favorite_collection_entity.dart';
import '../models/favorite_item_model.dart';
import '../models/favorite_collection_model.dart';

class FavoriteMapper {
  static FavoriteItemEntity toEntity(FavoriteItemModel model) {
    return FavoriteItemEntity(
      id: model.id,
      foodId: model.foodId,
      name: model.name,
      brand: model.brand,
      calories: model.calories,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      collectionId: model.collectionId,
      addedAt: DateTime.parse(model.addedAt),
    );
  }

  static FavoriteItemModel toModel(FavoriteItemEntity entity) {
    return FavoriteItemModel(
      id: entity.id,
      foodId: entity.foodId,
      name: entity.name,
      brand: entity.brand,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      collectionId: entity.collectionId,
      addedAt: entity.addedAt.toIso8601String(),
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
      iconAsset: model.iconAsset,
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
      iconAsset: entity.iconAsset,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }
}
