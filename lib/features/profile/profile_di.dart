import 'package:get_it/get_it.dart';

import 'data/datasource/profile_remote_datasource.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_about_us_usecase.dart';
import 'domain/usecases/get_patient_profile_usecase.dart';
import 'domain/usecases/get_privacy_policy_usecase.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/get_terms_of_service_usecase.dart';
import 'domain/usecases/update_patient_profile_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
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
  sl.registerLazySingleton(() => GetProfileUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(
    () => GetPatientProfileUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(
    () => UpdatePatientProfileUseCase(sl<ProfileRepository>()),
  );

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(
    () => ProfileBloc(
      getTermsOfService: sl<GetTermsOfServiceUseCase>(),
      getPrivacyPolicy: sl<GetPrivacyPolicyUseCase>(),
      getAboutUs: sl<GetAboutUsUseCase>(),
      getProfile: sl<GetProfileUseCase>(),
      updateProfile: sl<UpdateProfileUseCase>(),
      getPatientProfile: sl<GetPatientProfileUseCase>(),
      updatePatientProfile: sl<UpdatePatientProfileUseCase>(),
    ),
  );
}
