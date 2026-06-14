// remove_item_from_collection_usecase.dart
import '../repositories/favorite_repository.dart';

class RemoveItemFromCollectionUsecase {
  final FavoriteRepository _repository;

  const RemoveItemFromCollectionUsecase(this._repository);

  Future<void> call({required String collectionId, required String itemId}) =>
      _repository.removeItemFromCollection(
        collectionId: collectionId,
        itemId: itemId,
      );
}
