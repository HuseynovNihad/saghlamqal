import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/photo_product_entity.dart';
import '../../domain/usecases/analyze_image_use_case.dart';

part 'photo_scan_event.dart';
part 'photo_scan_state.dart';

class PhotoScanBloc extends Bloc<PhotoScanEvent, PhotoScanState> {
  final AnalyzeImageUseCase _analyzeImageUseCase;

  PhotoScanBloc(this._analyzeImageUseCase) : super(const PhotoScanInitial()) {
    on<PhotoAnalyzeRequested>(_onAnalyze);
    on<PhotoScanReset>(_onReset);
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
}
