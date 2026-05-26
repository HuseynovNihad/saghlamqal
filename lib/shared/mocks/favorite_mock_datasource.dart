// lib/data/datasources/mock/favorite_mock_datasource.dart

import 'package:kalori_tracker/core/constants/app_assets.dart';

import '../../features/favorites/data/datasources/remote/favorite_remote_datasource.dart';
import '../../features/favorites/data/models/favorite_collection_model.dart';
import '../../features/favorites/data/models/favorite_item_model.dart';

class FavoriteMockDatasource implements FavoriteRemoteDatasource {
  final List<FavoriteItemModel> _favorites = [
    FavoriteItemModel(
      id: 'fav_1',
      foodId: 'food_1',
      name: 'Chicken Breast',
      brand: 'Fitness',
      calories: 220,
      protein: 42,
      carbs: 0,
      fat: 5,
      collectionId: 'col_1',
      addedAt: DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    ),
    FavoriteItemModel(
      id: 'fav_2',
      foodId: 'food_2',
      name: 'Oatmeal',
      brand: 'Quaker',
      calories: 160,
      protein: 5,
      carbs: 30,
      fat: 3,
      collectionId: 'col_2',
      addedAt: DateTime.now().toIso8601String(),
    ),
    FavoriteItemModel(
      id: 'fav_3',
      foodId: 'food_3',
      name: 'Protein Bar',
      brand: 'Grenade',
      calories: 190,
      protein: 20,
      carbs: 15,
      fat: 7,
      collectionId: null,
      addedAt: DateTime.now().toIso8601String(),
    ),
  ];

  final List<FavoriteCollectionModel> _collections = [
    FavoriteCollectionModel(
      id: 'col_1',
      name: 'Gym',
      iconAsset: AppAssets.gym,
      createdAt: DateTime.now().toIso8601String(),
    ),
    FavoriteCollectionModel(
      id: 'col_2',
      name: 'Breakfast',
      iconAsset: AppAssets.breakfast,
      createdAt: DateTime.now().toIso8601String(),
    ),
    FavoriteCollectionModel(
      id: 'col_3',
      name: 'Snacks',
      iconAsset: AppAssets.snacks,
      createdAt: DateTime.now().toIso8601String(),
    ),
  ];

  @override
  Future<List<FavoriteItemModel>> getFavorites() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return List.from(_favorites);
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
    await Future.delayed(const Duration(milliseconds: 300));

    final item = FavoriteItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      foodId: foodId,
      name: name,
      brand: brand,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      collectionId: collectionId,
      addedAt: DateTime.now().toIso8601String(),
    );

    _favorites.insert(0, item);

    return item;
  }

  @override
  Future<void> removeFavorite(String id) async {
    await Future.delayed(const Duration(milliseconds: 250));

    _favorites.removeWhere((e) => e.id == id);
  }

  @override
  Future<List<FavoriteCollectionModel>> getCollections() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return List.from(_collections);
  }

  @override
  Future<FavoriteCollectionModel> createCollection({
    required String name,
    required String iconAsset,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final collection = FavoriteCollectionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      iconAsset: iconAsset,
      createdAt: DateTime.now().toIso8601String(),
    );

    _collections.add(collection);

    return collection;
  }

  @override
  Future<FavoriteCollectionModel> updateCollection({
    required String id,
    required String name,
    required String iconAsset,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _collections.indexWhere((e) => e.id == id);

    if (index == -1) {
      throw Exception('Collection not found');
    }

    final updated = FavoriteCollectionModel(
      id: _collections[index].id,
      name: name,
      iconAsset: iconAsset,
      createdAt: _collections[index].createdAt,
    );

    _collections[index] = updated;

    return updated;
  }

  @override
  Future<void> deleteCollection(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    _collections.removeWhere((e) => e.id == id);

    for (var i = 0; i < _favorites.length; i++) {
      final item = _favorites[i];

      if (item.collectionId == id) {
        _favorites[i] = FavoriteItemModel(
          id: item.id,
          foodId: item.foodId,
          name: item.name,
          brand: item.brand,
          calories: item.calories,
          protein: item.protein,
          carbs: item.carbs,
          fat: item.fat,
          collectionId: null,
          addedAt: item.addedAt,
        );
      }
    }
  }

  @override
  Future<FavoriteItemModel> assignCollection({
    required String favoriteId,
    required String? collectionId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _favorites.indexWhere((e) => e.id == favoriteId);

    if (index == -1) {
      throw Exception('Favorite not found');
    }

    final item = _favorites[index];

    final updated = FavoriteItemModel(
      id: item.id,
      foodId: item.foodId,
      name: item.name,
      brand: item.brand,
      calories: item.calories,
      protein: item.protein,
      carbs: item.carbs,
      fat: item.fat,
      collectionId: collectionId,
      addedAt: item.addedAt,
    );

    _favorites[index] = updated;

    return updated;
  }
}
