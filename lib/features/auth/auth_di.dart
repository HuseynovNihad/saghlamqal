import 'package:get_it/get_it.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/bloc/auth_bloc.dart';

Future<void> initAuth(GetIt sl) async {
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerFactory(() => AuthBloc(sl()));
}
