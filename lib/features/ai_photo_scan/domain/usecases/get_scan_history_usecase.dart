import '../entities/photo_scan_history_entity.dart';
import '../repositories/photo_scan_repository.dart';

class GetScanHistoryUsecase {
  final PhotoScanRepository _repository;

  const GetScanHistoryUsecase(this._repository);

  Future<List<PhotoScanHistoryEntity>> call() => _repository.getScanHistory();
}
