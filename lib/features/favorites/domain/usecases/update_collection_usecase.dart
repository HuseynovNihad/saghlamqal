import '../entities/favorite_collection_entity.dart';
import '../repositories/favorite_repository.dart';

class UpdateCollectionUsecase {
  final FavoriteRepository _repository;

  const UpdateCollectionUsecase(this._repository);

  Future<FavoriteCollectionEntity> call({
    required String id,
    required String name,
    required String emoji,
  }) => _repository.updateCollection(id: id, name: name, emoji: emoji);
}
