import '../../../../../../core/network/endpoints.dart';
import '../../../../../../core/network/network_manager.dart';

import '../../models/favorite_collection_model.dart';
import '../../models/favorite_item_model.dart';

abstract interface class FavoriteRemoteDatasource {
  Future<List<FavoriteItemModel>> getFavorites();

  Future<FavoriteItemModel> addFavorite({
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

  Future<List<FavoriteCollectionModel>> getCollections();

  Future<FavoriteCollectionModel> createCollection({
    required String name,
    required String iconAsset,
  });

  Future<FavoriteCollectionModel> updateCollection({
    required String id,
    required String name,
    required String iconAsset,
  });

  Future<void> deleteCollection(String id);

  Future<FavoriteItemModel> assignCollection({
    required String favoriteId,
    required String? collectionId,
  });
}

class FavoriteRemoteDatasourceImpl implements FavoriteRemoteDatasource {
  final NetworkManager _networkManager;

  const FavoriteRemoteDatasourceImpl(this._networkManager);

  @override
  Future<List<FavoriteItemModel>> getFavorites() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getFavorites,
    );

    return (response.data as List)
        .map((e) => FavoriteItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<FavoriteItemModel> addFavorite({
    required String foodId,
    required String name,
    String? brand,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    String? collectionId,
  }) async {
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.addFavorite,
      data: {
        'food_id': foodId,
        'name': name,
        if (brand != null) 'brand': brand,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        if (collectionId != null) 'collection_id': collectionId,
      },
    );

    return FavoriteItemModel.fromJson(response.data!);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await _networkManager.delete<void>(Endpoints.removeFavorite(id));
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
    required String iconAsset,
  }) async {
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.createCollection,
      data: {'name': name, 'iconAsset': iconAsset},
    );

    return FavoriteCollectionModel.fromJson(response.data!);
  }

  @override
  Future<FavoriteCollectionModel> updateCollection({
    required String id,
    required String name,
    required String iconAsset,
  }) async {
    final response = await _networkManager.put<Map<String, dynamic>>(
      Endpoints.updateCollection(id),
      data: {'name': name, 'emoji': iconAsset},
    );

    return FavoriteCollectionModel.fromJson(response.data!);
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _networkManager.delete<void>(Endpoints.deleteCollection(id));
  }

  @override
  Future<FavoriteItemModel> assignCollection({
    required String favoriteId,
    required String? collectionId,
  }) async {
    final response = await _networkManager.patch<Map<String, dynamic>>(
      Endpoints.assignCollection(favoriteId),
      data: {'collection_id': collectionId},
    );

    return FavoriteItemModel.fromJson(response.data!);
  }
}
