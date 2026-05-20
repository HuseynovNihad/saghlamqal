import '../entities/favorite_item_entity.dart';
import '../repositories/favorite_repository.dart';

class GetFavoritesUsecase {
  final FavoriteRepository _repository;

  const GetFavoritesUsecase(this._repository);

  Future<List<FavoriteItemEntity>> call() => _repository.getFavorites();
}
