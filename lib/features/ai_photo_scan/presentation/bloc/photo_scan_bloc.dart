import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/photo_product_entity.dart';
import '../../domain/entities/photo_scan_history_entity.dart';
import '../../domain/usecases/analyze_image_use_case.dart';
import '../../domain/usecases/get_scan_history_usecase.dart';
import '../../domain/usecases/delete_scan_history_usecase.dart';
import '../../domain/usecases/clear_scan_history_usecase.dart';

part 'photo_scan_event.dart';
part 'photo_scan_state.dart';

class PhotoScanBloc extends Bloc<PhotoScanEvent, PhotoScanState> {
  final AnalyzeImageUseCase _analyzeImageUseCase;
  final GetScanHistoryUsecase _getScanHistory;
  final DeleteScanHistoryUsecase _deleteScanHistory;
  final ClearScanHistoryUsecase _clearScanHistory;

  PhotoScanBloc({
    required AnalyzeImageUseCase analyzeImageUseCase,
    required GetScanHistoryUsecase getScanHistory,
    required DeleteScanHistoryUsecase deleteScanHistory,
    required ClearScanHistoryUsecase clearScanHistory,
  }) : _analyzeImageUseCase = analyzeImageUseCase,
       _getScanHistory = getScanHistory,
       _deleteScanHistory = deleteScanHistory,
       _clearScanHistory = clearScanHistory,
       super(const PhotoScanInitial()) {
    on<PhotoAnalyzeRequested>(_onAnalyze);
    on<PhotoScanReset>(_onReset);
    on<GetScanHistoryRequested>(_onGetHistory);
    on<DeleteScanHistoryRequested>(_onDeleteHistory);
    on<ClearScanHistoryRequested>(_onClearHistory);
  }

  Future<void> _onAnalyze(
    PhotoAnalyzeRequested event,
    Emitter<PhotoScanState> emit,
  ) async {
    emit(const PhotoScanLoading());
    try {
      final product = await _analyzeImageUseCase(event.imagePath);
      if (!product.isFood) {
        emit(const PhotoScanNotFood());
      } else {
        emit(PhotoScanSuccess(product));
      }
    } catch (e) {
      emit(PhotoScanError(e.toString()));
    }
  }

  void _onReset(PhotoScanReset event, Emitter<PhotoScanState> emit) {
    emit(const PhotoScanInitial());
  }

  Future<void> _onGetHistory(
    GetScanHistoryRequested event,
    Emitter<PhotoScanState> emit,
  ) async {
    emit(const PhotoScanLoading());
    try {
      final history = await _getScanHistory();
      emit(PhotoScanHistoryLoaded(history));
    } catch (e) {
      emit(PhotoScanError(e.toString()));
    }
  }

  Future<void> _onDeleteHistory(
    DeleteScanHistoryRequested event,
    Emitter<PhotoScanState> emit,
  ) async {
    try {
      await _deleteScanHistory(event.id);
      emit(const PhotoScanHistoryActionSuccess());
      final history = await _getScanHistory();
      emit(PhotoScanHistoryLoaded(history));
    } catch (e) {
      emit(PhotoScanError(e.toString()));
    }
  }

  Future<void> _onClearHistory(
    ClearScanHistoryRequested event,
    Emitter<PhotoScanState> emit,
  ) async {
    try {
      await _clearScanHistory();
      emit(const PhotoScanHistoryLoaded([]));
    } catch (e) {
      emit(PhotoScanError(e.toString()));
    }
  }
}
