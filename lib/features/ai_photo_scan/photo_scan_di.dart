import 'package:get_it/get_it.dart';

import '../../core/network/network_manager.dart';
import 'data/datasource/photo_scan_remote_data_source.dart';
import 'data/repositories/photo_scan_repository_impl.dart';
import 'domain/repositories/photo_scan_repository.dart';
import 'domain/usecases/analyze_image_use_case.dart';
import 'domain/usecases/get_scan_history_usecase.dart';
import 'domain/usecases/delete_scan_history_usecase.dart';
import 'domain/usecases/clear_scan_history_usecase.dart';
import 'presentation/bloc/photo_scan_bloc.dart';

Future<void> initPhotoScan(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<PhotoScanRemoteDataSource>(
    () => PhotoScanRemoteDataSourceImpl(sl<NetworkManager>()),
  );

  // ─────────────────────────────────────────────────────────────
  // REPOSITORY
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<PhotoScanRepository>(
    () => PhotoScanRepositoryImpl(sl<PhotoScanRemoteDataSource>()),
  );

  // ─────────────────────────────────────────────────────────────
  // USE CASES
  // ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(
    () => AnalyzeImageUseCase(sl<PhotoScanRepository>()),
  );
  sl.registerLazySingleton(
    () => GetScanHistoryUsecase(sl<PhotoScanRepository>()),
  );
  sl.registerLazySingleton(
    () => DeleteScanHistoryUsecase(sl<PhotoScanRepository>()),
  );
  sl.registerLazySingleton(
    () => ClearScanHistoryUsecase(sl<PhotoScanRepository>()),
  );

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────
  sl.registerFactory(
    () => PhotoScanBloc(
      analyzeImageUseCase: sl<AnalyzeImageUseCase>(),
      getScanHistory: sl<GetScanHistoryUsecase>(),
      deleteScanHistory: sl<DeleteScanHistoryUsecase>(),
      clearScanHistory: sl<ClearScanHistoryUsecase>(),
    ),
  );
}
