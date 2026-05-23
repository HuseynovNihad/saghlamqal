import 'package:get_it/get_it.dart';

import '../../core/config/app_config.dart';
import '../../shared/mocks/mock_home_remote_datasource.dart';
import 'data/datasource/home_remote_datasource.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/add_water_usecase.dart';
import 'domain/usecases/get_daily_goal.dart';
import 'domain/usecases/get_hydration_usecase.dart';
import 'domain/usecases/get_meal_of_the_day_usecase.dart';
import 'domain/usecases/get_recent_products_usecase.dart';
import 'presentation/bloc/home_bloc.dart';

Future<void> initHome(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  if (AppConfig.useMock) {
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => MockHomeRemoteDataSource(),
    );
  } else {
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(() => GetDailyGoal(sl<HomeRepository>()));
  sl.registerLazySingleton(() => GetHydration(sl<HomeRepository>()));
  sl.registerLazySingleton(() => AddWater(sl<HomeRepository>()));
  sl.registerLazySingleton(
    () => GetRecentProductsUseCase(sl<HomeRepository>()),
  );
  sl.registerLazySingleton(() => GetMealOfTheDay(sl<HomeRepository>()));

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => HomeBloc(
      getDailyGoal: sl<GetDailyGoal>(),
      getHydration: sl<GetHydration>(),
      addWater: sl<AddWater>(),
      getRecentProducts: sl<GetRecentProductsUseCase>(),
      getMealOfTheDay: sl<GetMealOfTheDay>(),
    ),
  );
}
