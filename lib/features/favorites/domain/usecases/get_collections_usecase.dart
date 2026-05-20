import '../entities/favorite_collection_entity.dart';
import '../repositories/favorite_repository.dart';

class GetCollectionsUsecase {
  final FavoriteRepository _repository;

  const GetCollectionsUsecase(this._repository);

  Future<List<FavoriteCollectionEntity>> call() => _repository.getCollections();
}
