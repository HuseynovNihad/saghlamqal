import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/favorite_item_entity.dart';
import '../../domain/entities/favorite_collection_entity.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import '../../domain/usecases/get_collections_usecase.dart';
import '../../domain/usecases/create_collection_usecase.dart';
import '../../domain/usecases/delete_collection_usecase.dart';
import '../../domain/usecases/add_item_to_collection_usecase.dart';
import '../../domain/usecases/remove_item_from_collection_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUsecase _getFavorites;
  final AddFavoriteUsecase _addFavorite;
  final RemoveFavoriteUsecase _removeFavorite;
  final GetCollectionsUsecase _getCollections;
  final CreateCollectionUsecase _createCollection;
  final DeleteCollectionUsecase _deleteCollection;
  final AddItemToCollectionUsecase _addItemToCollection;
  final RemoveItemFromCollectionUsecase _removeItemFromCollection;

  FavoritesBloc({
    required GetFavoritesUsecase getFavorites,
    required AddFavoriteUsecase addFavorite,
    required RemoveFavoriteUsecase removeFavorite,
    required GetCollectionsUsecase getCollections,
    required CreateCollectionUsecase createCollection,
    required DeleteCollectionUsecase deleteCollection,
    required AddItemToCollectionUsecase addItemToCollection,
    required RemoveItemFromCollectionUsecase removeItemFromCollection,
  }) : _getFavorites = getFavorites,
       _addFavorite = addFavorite,
       _removeFavorite = removeFavorite,
       _getCollections = getCollections,
       _createCollection = createCollection,
       _deleteCollection = deleteCollection,
       _addItemToCollection = addItemToCollection,
       _removeItemFromCollection = removeItemFromCollection,
       super(FavoritesInitial()) {
    on<GetFavoritesEvent>(_onGetFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<GetCollectionsEvent>(_onGetCollections);
    on<CreateCollectionEvent>(_onCreateCollection);
    on<DeleteCollectionEvent>(_onDeleteCollection);
    on<AddItemToCollectionEvent>(_onAddItemToCollection);
    on<RemoveItemFromCollectionEvent>(_onRemoveItemFromCollection);
  }

  // ─── Helpers ────────────────────────────────────────────────────

  List<FavoriteItemEntity> get _currentFavorites => switch (state) {
    FavoritesLoaded s => s.favorites,
    FavoriteActionLoading s => s.favorites,
    FavoriteActionSuccess s => s.favorites,
    _ => [],
  };

  List<FavoriteCollectionEntity> get _currentCollections => switch (state) {
    FavoritesLoaded s => s.collections,
    FavoriteActionLoading s => s.collections,
    FavoriteActionSuccess s => s.collections,
    _ => [],
  };

  // ─── Handlers ───────────────────────────────────────────────────

  Future<void> _onGetFavorites(
    GetFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await _getFavorites();
      final collections = await _getCollections();
      emit(FavoritesLoaded(favorites: favorites, collections: collections));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      final newItem = await _addFavorite(
        name: event.name,
        calories: event.calories,
        protein: event.protein,
        carbs: event.carbs,
        fat: event.fat,
        vitamins: event.vitamins,
        advice: event.advice,
        isFood: event.isFood,
        servingSize: event.servingSize,
        servingUnit: event.servingUnit,
      );
      final updated = [..._currentFavorites, newItem];
      emit(
        FavoriteActionSuccess(
          favorites: updated,
          collections: _currentCollections,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      await _removeFavorite(event.id);
      final updated = _currentFavorites.where((f) => f.id != event.id).toList();
      emit(
        FavoriteActionSuccess(
          favorites: updated,
          collections: _currentCollections,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onGetCollections(
    GetCollectionsEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final collections = await _getCollections();
      emit(
        FavoritesLoaded(favorites: _currentFavorites, collections: collections),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onCreateCollection(
    CreateCollectionEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      final newCollection = await _createCollection(
        name: event.name,
        description: event.description,
        icon: event.icon,
      );
      final updated = [..._currentCollections, newCollection];
      emit(
        FavoriteActionSuccess(
          favorites: _currentFavorites,
          collections: updated,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onDeleteCollection(
    DeleteCollectionEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      await _deleteCollection(event.id);
      final updatedCollections = _currentCollections
          .where((c) => c.id != event.id)
          .toList();
      emit(
        FavoriteActionSuccess(
          favorites: _currentFavorites,
          collections: updatedCollections,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAddItemToCollection(
    AddItemToCollectionEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      await _addItemToCollection(
        collectionId: event.collectionId,
        name: event.name,
        calories: event.calories,
        protein: event.protein,
        carbs: event.carbs,
        fat: event.fat,
        vitamins: event.vitamins,
        advice: event.advice,
        isFood: event.isFood,
        servingSize: event.servingSize,
        servingUnit: event.servingUnit,
      );
      emit(
        FavoriteActionSuccess(
          favorites: _currentFavorites,
          collections: _currentCollections,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onRemoveItemFromCollection(
    RemoveItemFromCollectionEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      FavoriteActionLoading(
        favorites: _currentFavorites,
        collections: _currentCollections,
      ),
    );
    try {
      await _removeItemFromCollection(
        collectionId: event.collectionId,
        itemId: event.itemId,
      );
      emit(
        FavoriteActionSuccess(
          favorites: _currentFavorites,
          collections: _currentCollections,
        ),
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
