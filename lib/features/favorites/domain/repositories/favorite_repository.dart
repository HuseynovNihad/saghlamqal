import '../entities/favorite_item_entity.dart';
import '../entities/favorite_collection_entity.dart';

abstract interface class FavoriteRepository {
  Future<List<FavoriteItemEntity>> getFavorites();

  Future<FavoriteItemEntity> addFavorite({
    required String name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    Map<String, dynamic>? vitamins,
    String? advice,
    required bool isFood,
    double? servingSize,
    String? servingUnit,
  });

  Future<void> removeFavorite(String id);

  Future<List<FavoriteCollectionEntity>> getCollections();

  Future<FavoriteCollectionEntity> createCollection({
    required String name,
    String? description,
    String? icon,
  });

  Future<void> deleteCollection(String id);

  Future<void> addItemToCollection({
    required String collectionId,
    required String name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    Map<String, dynamic>? vitamins,
    String? advice,
    required bool isFood,
    double? servingSize,
    String? servingUnit,
  });

  Future<void> removeItemFromCollection({
    required String collectionId,
    required String itemId,
  });
}
