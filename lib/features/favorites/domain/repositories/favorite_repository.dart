import '../entities/favorite_item_entity.dart';
import '../entities/favorite_collection_entity.dart';

abstract interface class FavoriteRepository {
  Future<List<FavoriteItemEntity>> getFavorites();

  Future<FavoriteItemEntity> addFavorite({
    required String foodId,
    required String name,
    String? brand,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    String? collectionId,
  });

  Future<void> removeFavorite(String id);

  Future<List<FavoriteCollectionEntity>> getCollections();

  Future<FavoriteCollectionEntity> createCollection({
    required String name,
    required String emoji,
  });

  Future<FavoriteCollectionEntity> updateCollection({
    required String id,
    required String name,
    required String emoji,
  });

  Future<void> deleteCollection(String id);

  Future<FavoriteItemEntity> assignCollection({
    required String favoriteId,
    required String? collectionId,
  });
}
