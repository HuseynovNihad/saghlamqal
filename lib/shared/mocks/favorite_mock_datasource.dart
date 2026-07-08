import '../../features/favorites/data/datasources/remote/favorite_remote_datasource.dart';
import '../../features/favorites/data/models/favorite_collection_model.dart';
import '../../features/favorites/data/models/favorite_item_model.dart';

class FavoriteMockDatasource implements FavoriteRemoteDatasource {
  final List<FavoriteItemModel> _favorites = [
    FavoriteItemModel(
      id: 'fav_1',
      name: 'Chicken Breast',
      calories: 220,
      protein: 42,
      carbs: 0,
      fat: 5,
      vitamins: null,
      advice: null,
      isFood: true,
      servingSize: 100,
      servingUnit: 'g',
      createdAt: DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    ),
    FavoriteItemModel(
      id: 'fav_2',
      name: 'Oatmeal',
      calories: 160,
      protein: 5,
      carbs: 30,
      fat: 3,
      vitamins: null,
      advice: null,
      isFood: true,
      servingSize: 100,
      servingUnit: 'g',
      createdAt: DateTime.now().toIso8601String(),
    ),
    FavoriteItemModel(
      id: 'fav_3',
      name: 'Protein Bar',
      calories: 190,
      protein: 20,
      carbs: 15,
      fat: 7,
      vitamins: null,
      advice: null,
      isFood: true,
      servingSize: 100,
      servingUnit: 'g',
      createdAt: DateTime.now().toIso8601String(),
    ),
  ];

  final List<FavoriteCollectionModel> _collections = [
    FavoriteCollectionModel(
      id: 'col_1',
      name: 'Gym',
      icon: 'gym',
      description: null,
      createdAt: DateTime.now().toIso8601String(),
    ),
    FavoriteCollectionModel(
      id: 'col_2',
      name: 'Breakfast',
      icon: 'breakfast',
      description: null,
      createdAt: DateTime.now().toIso8601String(),
    ),
    FavoriteCollectionModel(
      id: 'col_3',
      name: 'Snacks',
      icon: 'snack',
      description: null,
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
    await Future.delayed(const Duration(milliseconds: 300));

    final item = FavoriteItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
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
      createdAt: DateTime.now().toIso8601String(),
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
    String? description,
    String? icon,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final collection = FavoriteCollectionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      icon: icon,
      description: description,
      createdAt: DateTime.now().toIso8601String(),
    );

    _collections.add(collection);
    return collection;
  }

  @override
  Future<void> deleteCollection(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _collections.removeWhere((e) => e.id == id);
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
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock: sadəcə geri qaytarırıq
  }

  @override
  Future<void> removeItemFromCollection({
    required String collectionId,
    required String itemId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock: sadəcə geri qaytarırıq
  }
}
