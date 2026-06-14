part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {
  const FavoritesEvent();
}

final class GetFavoritesEvent extends FavoritesEvent {}

final class AddFavoriteEvent extends FavoritesEvent {
  final String name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, dynamic>? vitamins;
  final String? advice;
  final bool isFood;
  final double? servingSize;
  final String? servingUnit;

  const AddFavoriteEvent({
    required this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    this.advice,
    required this.isFood,
    this.servingSize,
    this.servingUnit,
  });
}

final class RemoveFavoriteEvent extends FavoritesEvent {
  final String id;

  const RemoveFavoriteEvent(this.id);
}

final class GetCollectionsEvent extends FavoritesEvent {}

final class CreateCollectionEvent extends FavoritesEvent {
  final String name;
  final String? description;
  final String? icon;

  const CreateCollectionEvent({
    required this.name,
    this.description,
    this.icon,
  });
}

final class DeleteCollectionEvent extends FavoritesEvent {
  final String id;

  const DeleteCollectionEvent(this.id);
}

final class AddItemToCollectionEvent extends FavoritesEvent {
  final String collectionId;
  final String name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, dynamic>? vitamins;
  final String? advice;
  final bool isFood;
  final double? servingSize;
  final String? servingUnit;

  const AddItemToCollectionEvent({
    required this.collectionId,
    required this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    this.advice,
    required this.isFood,
    this.servingSize,
    this.servingUnit,
  });
}

final class RemoveItemFromCollectionEvent extends FavoritesEvent {
  final String collectionId;
  final String itemId;

  const RemoveItemFromCollectionEvent({
    required this.collectionId,
    required this.itemId,
  });
}
