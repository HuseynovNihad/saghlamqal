// create_collection_usecase.dart
import '../entities/favorite_collection_entity.dart';
import '../repositories/favorite_repository.dart';

class CreateCollectionUsecase {
  final FavoriteRepository _repository;

  const CreateCollectionUsecase(this._repository);

  Future<FavoriteCollectionEntity> call({
    required String name,
    String? description,
    String? icon,
  }) => _repository.createCollection(
    name: name,
    description: description,
    icon: icon,
  );
}
