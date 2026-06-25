import 'package:get_it/get_it.dart';

import 'data/datasource/profile_remote_datasource.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_about_us_usecase.dart';
import 'domain/usecases/get_privacy_policy_usecase.dart';
import 'domain/usecases/get_terms_of_service_usecase.dart';
import 'presentation/bloc/profile_bloc.dart';

Future<void> initProfile(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton(
    () => GetTermsOfServiceUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(
    () => GetPrivacyPolicyUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(() => GetAboutUsUseCase(sl<ProfileRepository>()));

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => ProfileBloc(
      getTermsOfService: sl<GetTermsOfServiceUseCase>(),
      getPrivacyPolicy: sl<GetPrivacyPolicyUseCase>(),
      getAboutUs: sl<GetAboutUsUseCase>(),
    ),
  );
}
