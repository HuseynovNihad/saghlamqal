import '../entities/favorite_item_entity.dart';
import '../repositories/favorite_repository.dart';

class AssignCollectionUsecase {
  final FavoriteRepository _repository;

  const AssignCollectionUsecase(this._repository);

  Future<FavoriteItemEntity> call({
    required String favoriteId,
    required String? collectionId,
  }) => _repository.assignCollection(
    favoriteId: favoriteId,
    collectionId: collectionId,
  );
}
