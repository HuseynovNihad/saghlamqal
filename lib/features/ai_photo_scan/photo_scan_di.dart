import 'package:get_it/get_it.dart';

import '../../core/network/gemini_manager.dart';
import 'data/datasource/photo_scan_remote_data_source.dart';
import 'data/repositories/photo_scan_repository_impl.dart';
import 'domain/repositories/photo_scan_repository.dart';
import 'domain/usecases/analyze_image_use_case.dart';
import 'presentation/bloc/photo_scan_bloc.dart';

Future<void> initPhotoScan(GetIt sl) async {
  // ─────────────────────────────────────────────────────────────
  // MANAGER
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<GeminiManager>(() => GeminiManager());

  // ─────────────────────────────────────────────────────────────
  // DATASOURCE
  // ─────────────────────────────────────────────────────────────

  sl.registerLazySingleton<PhotoScanRemoteDataSource>(
    () => PhotoScanRemoteDataSourceImpl(sl<GeminiManager>()),
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

  // ─────────────────────────────────────────────────────────────
  // BLOC
  // ─────────────────────────────────────────────────────────────

  sl.registerFactory(() => PhotoScanBloc(sl<AnalyzeImageUseCase>()));
}
