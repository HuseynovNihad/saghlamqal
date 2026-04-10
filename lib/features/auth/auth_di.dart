import '../../core/di/injection_container.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/bloc/auth_bloc.dart';

void initAuth() {
  sl.registerFactory(() => AuthBloc(sl()));

  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
}
