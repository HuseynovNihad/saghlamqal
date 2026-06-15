import '../repositories/photo_scan_repository.dart';

class ClearScanHistoryUsecase {
  final PhotoScanRepository _repository;

  const ClearScanHistoryUsecase(this._repository);

  Future<void> call() => _repository.clearScanHistory();
}
