import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_scan_repository.dart';
import 'scan_event.dart';
import 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final IScanRepository _repository;

  ScanBloc(this._repository) : super(ScanInitial()) {
    on<ProductFetchRequested>(_onFetch);
    on<ScanReset>((_, emit) => emit(ScanInitial()));
  }

  Future<void> _onFetch(
    ProductFetchRequested event,
    Emitter<ScanState> emit,
  ) async {
    emit(ScanLoading());
    try {
      final product = await _repository.getProductByBarcode(event.barcode);
      if (product == null) {
        emit(ScanNotFound());
      } else {
        emit(ScanSuccess(product));
      }
    } on Exception catch (e) {
      emit(ScanError(e.toString()));
    }
  }
}
