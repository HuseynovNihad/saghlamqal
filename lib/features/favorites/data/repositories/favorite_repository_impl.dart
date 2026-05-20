import '../../domain/entities/favorite_collection_entity.dart';
import '../../domain/entities/favorite_item_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/remote/favorite_remote_datasource.dart';
import '../mappers/favorite_mapper.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDatasource _remoteDatasource;

  const FavoriteRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<FavoriteItemEntity>> getFavorites() async {
    final models = await _remoteDatasource.getFavorites();
    return FavoriteMapper.toEntityList(models);
  }

  @override
  Future<FavoriteItemEntity> addFavorite({
    required String foodId,
    required String name,
    String? brand,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    String? collectionId,
  }) async {
    final model = await _remoteDatasource.addFavorite(
      foodId: foodId,
      name: name,
      brand: brand,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      collectionId: collectionId,
    );
    return FavoriteMapper.toEntity(model);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await _remoteDatasource.removeFavorite(id);
  }

  @override
  Future<List<FavoriteCollectionEntity>> getCollections() async {
    final models = await _remoteDatasource.getCollections();
    return models
        .map((model) => FavoriteMapper.toCollectionEntity(model))
        .toList();
  }

  @override
  Future<FavoriteCollectionEntity> createCollection({
    required String name,
    required String emoji,
  }) async {
    final model = await _remoteDatasource.createCollection(
      name: name,
      emoji: emoji,
    );
    return FavoriteMapper.toCollectionEntity(model);
  }

  @override
  Future<FavoriteCollectionEntity> updateCollection({
    required String id,
    required String name,
    required String emoji,
  }) async {
    final model = await _remoteDatasource.updateCollection(
      id: id,
      name: name,
      emoji: emoji,
    );
    return FavoriteMapper.toCollectionEntity(model);
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _remoteDatasource.deleteCollection(id);
  }

  @override
  Future<FavoriteItemEntity> assignCollection({
    required String favoriteId,
    required String? collectionId,
  }) async {
    final model = await _remoteDatasource.assignCollection(
      favoriteId: favoriteId,
      collectionId: collectionId,
    );
    return FavoriteMapper.toEntity(model);
  }
}
