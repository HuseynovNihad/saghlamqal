import '../repositories/favorite_repository.dart';

class AddItemToCollectionUsecase {
  final FavoriteRepository _repository;

  const AddItemToCollectionUsecase(this._repository);

  Future<void> call({
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
  }) => _repository.addItemToCollection(
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
