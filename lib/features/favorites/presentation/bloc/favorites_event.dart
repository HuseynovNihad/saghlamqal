part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {
  const FavoritesEvent();
}

final class GetFavoritesEvent extends FavoritesEvent {}

final class AddFavoriteEvent extends FavoritesEvent {
  final String foodId;
  final String name;
  final String? brand;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String? collectionId;

  AddFavoriteEvent({
    required this.foodId,
    required this.name,
    this.brand,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.collectionId,
  });
}

final class RemoveFavoriteEvent extends FavoritesEvent {
  final String id;

  const RemoveFavoriteEvent(this.id);
}

final class GetCollectionsEvent extends FavoritesEvent {}

final class CreateCollectionEvent extends FavoritesEvent {
  final String name;
  final String emoji;

  const CreateCollectionEvent({required this.name, required this.emoji});
}

final class UpdateCollectionEvent extends FavoritesEvent {
  final String id;
  final String name;
  final String emoji;

  const UpdateCollectionEvent({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

final class DeleteCollectionEvent extends FavoritesEvent {
  final String id;

  const DeleteCollectionEvent(this.id);
}

final class AssignCollectionEvent extends FavoritesEvent {
  final String favoriteId;
  final String? collectionId;

  const AssignCollectionEvent({
    required this.favoriteId,
    required this.collectionId,
  });
}
