import '../repositories/favorite_repository.dart';

class DeleteCollectionUsecase {
  final FavoriteRepository _repository;

  const DeleteCollectionUsecase(this._repository);

  Future<void> call(String id) => _repository.deleteCollection(id);
}
