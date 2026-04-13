import 'package:get_it/get_it.dart';

import '../../core/network/open_food_facts_manager.dart';
import 'data/datasource/scan_remote_data_source.dart';
import 'data/repositories/scan_repository.dart';
import 'domain/repositories/i_scan_repository.dart';
import 'presentation/bloc/scan_bloc.dart';

Future<void> initScan(GetIt sl) async {
  sl.registerLazySingleton(() => OpenFoodFactsManager());

  sl.registerLazySingleton<IScanRemoteDataSource>(
    () => ScanRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<IScanRepository>(() => ScanRepository(sl()));

  sl.registerFactory(() => ScanBloc(sl()));
}
