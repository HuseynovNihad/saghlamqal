part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {
  const FavoritesState();
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<FavoriteItemEntity> favorites;
  final List<FavoriteCollectionEntity> collections;

  const FavoritesLoaded({required this.favorites, required this.collections});

  FavoritesLoaded copyWith({
    List<FavoriteItemEntity>? favorites,
    List<FavoriteCollectionEntity>? collections,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      collections: collections ?? this.collections,
    );
  }
}

final class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);
}

final class FavoriteActionLoading extends FavoritesState {
  final List<FavoriteItemEntity> favorites;
  final List<FavoriteCollectionEntity> collections;

  const FavoriteActionLoading({
    required this.favorites,
    required this.collections,
  });
}

final class FavoriteActionSuccess extends FavoritesState {
  final List<FavoriteItemEntity> favorites;
  final List<FavoriteCollectionEntity> collections;

  const FavoriteActionSuccess({
    required this.favorites,
    required this.collections,
  });
}
