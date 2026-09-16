import 'package:get_it/get_it.dart';

import 'data/datasource/dietitians_remote_datasource.dart';
import 'data/repositories/dietitians_repository_impl.dart';

import 'domain/repositories/dietitians_repository.dart';

import 'domain/usecases/accept_dietitian_invite_usecase.dart';
import 'domain/usecases/get_active_diet_plan_usecase.dart';
import 'domain/usecases/get_dietitian_invites_usecase.dart';
import 'domain/usecases/get_diet_plan_check_ins_usecase.dart';
import 'domain/usecases/get_diet_plan_history_usecase.dart';
import 'domain/usecases/get_my_dietitian_usecase.dart';
import 'domain/usecases/reject_dietitian_invite_usecase.dart';
import 'domain/usecases/update_meal_check_in_usecase.dart';

import 'presentation/bloc/dietitians_bloc.dart';

Future<void> initDietitians(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<DietitiansRemoteDataSource>(
    () => DietitiansRemoteDataSourceImpl(sl()),
  );

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<DietitiansRepository>(
    () => DietitiansRepositoryImpl(sl<DietitiansRemoteDataSource>()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(
    () => GetMyDietitianUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => GetDietitianInvitesUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => AcceptDietitianInviteUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => RejectDietitianInviteUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => GetActiveDietPlanUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => GetDietPlanHistoryUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => GetDietPlanCheckInsUseCase(sl<DietitiansRepository>()),
  );

  sl.registerLazySingleton(
    () => UpdateMealCheckInUseCase(sl<DietitiansRepository>()),
  );

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => DietitiansBloc(
      getMyDietitianUseCase: sl<GetMyDietitianUseCase>(),
      getDietitianInvitesUseCase: sl<GetDietitianInvitesUseCase>(),
      acceptDietitianInviteUseCase: sl<AcceptDietitianInviteUseCase>(),
      rejectDietitianInviteUseCase: sl<RejectDietitianInviteUseCase>(),
      getActiveDietPlanUseCase: sl<GetActiveDietPlanUseCase>(),
      getDietPlanHistoryUseCase: sl<GetDietPlanHistoryUseCase>(),
      getDietPlanCheckInsUseCase: sl<GetDietPlanCheckInsUseCase>(),
      updateMealCheckInUseCase: sl<UpdateMealCheckInUseCase>(),
    ),
  );
}
