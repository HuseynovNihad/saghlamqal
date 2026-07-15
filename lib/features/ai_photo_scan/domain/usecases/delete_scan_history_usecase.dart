import '../repositories/photo_scan_repository.dart';

class DeleteScanHistoryUsecase {
  final PhotoScanRepository _repository;

  const DeleteScanHistoryUsecase(this._repository);

  Future<void> call(String id) => _repository.deleteScanHistory(id);
}
