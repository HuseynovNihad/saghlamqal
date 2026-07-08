import '../../../../../../core/network/endpoints.dart';
import '../../../../../../core/network/network_manager.dart';

import '../../models/favorite_collection_model.dart';
import '../../models/favorite_item_model.dart';

abstract interface class FavoriteRemoteDatasource {
  Future<List<FavoriteItemModel>> getFavorites();

  Future<FavoriteItemModel> addFavorite({
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
  });

  Future<void> removeFavorite(String id);

  Future<List<FavoriteCollectionModel>> getCollections();

  Future<FavoriteCollectionModel> createCollection({
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

class FavoriteRemoteDatasourceImpl implements FavoriteRemoteDatasource {
  final NetworkManager _networkManager;

  const FavoriteRemoteDatasourceImpl(this._networkManager);

  @override
  Future<List<FavoriteItemModel>> getFavorites() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getScanFavorites,
    );

    return (response.data as List)
        .map((e) => FavoriteItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<FavoriteItemModel> addFavorite({
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
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.addScanFavorite,
      data: {
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'vitamins': vitamins,
        'advice': advice,
        'is_food': isFood,
        'serving_size': servingSize,
        'serving_unit': servingUnit,
      },
    );

    return FavoriteItemModel.fromJson(response.data!);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await _networkManager.delete<void>(Endpoints.deleteScanFavorite(id));
  }

  @override
  Future<List<FavoriteCollectionModel>> getCollections() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getCollections,
    );

    return (response.data as List)
        .map((e) => FavoriteCollectionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<FavoriteCollectionModel> createCollection({
    required String name,
    String? description,
    String? icon,
  }) async {
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.createCollection,
      data: {
        'name': name,
        if (description != null) 'description': description,
        if (icon != null) 'icon': icon,
      },
    );

    return FavoriteCollectionModel.fromJson(response.data!);
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _networkManager.delete<void>(Endpoints.deleteCollection(id));
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
    await _networkManager.post<Map<String, dynamic>>(
      Endpoints.addCollectionItem(collectionId),
      data: {
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'vitamins': vitamins,
        'advice': advice,
        'is_food': isFood,
        'serving_size': servingSize,
        'serving_unit': servingUnit,
      },
    );
  }

  @override
  Future<void> removeItemFromCollection({
    required String collectionId,
    required String itemId,
  }) async {
    await _networkManager.delete<void>(
      Endpoints.removeCollectionItem(collectionId, itemId),
    );
  }
}
