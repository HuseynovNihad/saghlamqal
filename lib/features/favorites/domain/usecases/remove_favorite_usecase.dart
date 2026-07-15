import '../repositories/favorite_repository.dart';

class RemoveFavoriteUsecase {
  final FavoriteRepository _repository;

  const RemoveFavoriteUsecase(this._repository);

  Future<void> call(String id) => _repository.removeFavorite(id);
}
