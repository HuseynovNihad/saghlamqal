import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../shared/mocks/favorite_mock_datasource.dart';
import 'data/datasources/remote/favorite_remote_datasource.dart';
import 'data/repositories/favorite_repository_impl.dart';
import 'domain/repositories/favorite_repository.dart';
import 'domain/usecases/add_favorite_usecase.dart';
import 'domain/usecases/add_item_to_collection_usecase.dart';
import 'domain/usecases/create_collection_usecase.dart';
import 'domain/usecases/delete_collection_usecase.dart';
import 'domain/usecases/get_collections_usecase.dart';
import 'domain/usecases/get_favorites_usecase.dart';
import 'domain/usecases/remove_favorite_usecase.dart';
import 'domain/usecases/remove_item_from_collection_usecase.dart';
import 'presentation/bloc/favorites_bloc.dart';

Future<void> initFavorites(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  if (AppConfig.useMock) {
    sl.registerLazySingleton<FavoriteRemoteDatasource>(
      () => FavoriteMockDatasource(),
    );
  } else {
    sl.registerLazySingleton<FavoriteRemoteDatasource>(
      () => FavoriteRemoteDatasourceImpl(sl()),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(sl<FavoriteRemoteDatasource>()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(() => GetFavoritesUsecase(sl<FavoriteRepository>()));
  sl.registerLazySingleton(() => AddFavoriteUsecase(sl<FavoriteRepository>()));
  sl.registerLazySingleton(
    () => RemoveFavoriteUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
    () => GetCollectionsUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
    () => CreateCollectionUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
    () => DeleteCollectionUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
    () => AddItemToCollectionUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
    () => RemoveItemFromCollectionUsecase(sl<FavoriteRepository>()),
  );

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => FavoritesBloc(
      getFavorites: sl<GetFavoritesUsecase>(),
      addFavorite: sl<AddFavoriteUsecase>(),
      removeFavorite: sl<RemoveFavoriteUsecase>(),
      getCollections: sl<GetCollectionsUsecase>(),
      createCollection: sl<CreateCollectionUsecase>(),
      deleteCollection: sl<DeleteCollectionUsecase>(),
      addItemToCollection: sl<AddItemToCollectionUsecase>(),
      removeItemFromCollection: sl<RemoveItemFromCollectionUsecase>(),
    ),
  );
}
