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
    required String name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    Map<String, dynamic>? vitamins,
    List<String>? advice,
    required bool isFood,
    int? servingSize,
    String? servingUnit,
  }) async {
    final model = await _remoteDatasource.addFavorite(
      name: name,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      vitamins: vitamins,
      advice: advice,
      isFood: isFood,
      servingSize: servingSize,
      servingUnit: servingUnit,
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
    String? description,
    String? icon,
  }) async {
    final model = await _remoteDatasource.createCollection(
      name: name,
      description: description,
      icon: icon,
    );
    return FavoriteMapper.toCollectionEntity(model);
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _remoteDatasource.deleteCollection(id);
  }

  @override
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
  }) async {
    await _remoteDatasource.addItemToCollection(
      collectionId: collectionId,
      name: name,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      vitamins: vitamins,
      advice: advice,
      isFood: isFood,
      servingSize: servingSize,
      servingUnit: servingUnit,
    );
  }

  @override
  Future<void> removeItemFromCollection({
    required String collectionId,
    required String itemId,
  }) async {
    await _remoteDatasource.removeItemFromCollection(
      collectionId: collectionId,
      itemId: itemId,
    );
  }
}
