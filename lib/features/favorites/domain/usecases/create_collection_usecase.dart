import '../entities/favorite_collection_entity.dart';
import '../repositories/favorite_repository.dart';

class CreateCollectionUsecase {
  final FavoriteRepository _repository;

  const CreateCollectionUsecase(this._repository);

  Future<FavoriteCollectionEntity> call({
    required String name,
    required String iconAsset,
  }) => _repository.createCollection(name: name, iconAsset: iconAsset);
}
