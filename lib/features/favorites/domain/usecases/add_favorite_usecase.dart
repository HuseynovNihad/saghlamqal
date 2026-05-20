import '../entities/favorite_item_entity.dart';
import '../repositories/favorite_repository.dart';

class AddFavoriteUsecase {
  final FavoriteRepository _repository;

  const AddFavoriteUsecase(this._repository);

  Future<FavoriteItemEntity> call({
    required String foodId,
    required String name,
    String? brand,
    required double calories,
    required double protein,
    required double carbs,
    required double fat,
    String? collectionId,
  }) => _repository.addFavorite(
    foodId: foodId,
    name: name,
    brand: brand,
    calories: calories,
    protein: protein,
    carbs: carbs,
    fat: fat,
    collectionId: collectionId,
  );
}
