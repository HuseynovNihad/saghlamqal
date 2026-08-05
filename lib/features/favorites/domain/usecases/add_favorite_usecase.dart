import '../entities/favorite_item_entity.dart';
import '../repositories/favorite_repository.dart';

class AddFavoriteUsecase {
  final FavoriteRepository _repository;

  const AddFavoriteUsecase(this._repository);

  Future<FavoriteItemEntity> call({
    required String name,
    String? icon,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    Map<String, dynamic>? vitamins,
    List<String>? advice,
    required bool isFood,
    int? servingSize,
    String? servingUnit,
    String? historyId,
  }) => _repository.addFavorite(
    name: name,
    icon: icon,
    calories: calories,
    protein: protein,
    carbs: carbs,
    fat: fat,
    vitamins: vitamins,
    advice: advice,
    isFood: isFood,
    servingSize: servingSize,
    servingUnit: servingUnit,
    historyId: historyId,
  );
}
