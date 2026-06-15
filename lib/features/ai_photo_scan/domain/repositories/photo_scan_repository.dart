import '../entities/photo_product_entity.dart';
import '../entities/photo_scan_history_entity.dart';

abstract class PhotoScanRepository {
  Future<PhotoProductEntity> analyzeImage(String imagePath);
  Future<List<PhotoScanHistoryEntity>> getScanHistory();
  Future<void> deleteScanHistory(String id);
  Future<void> clearScanHistory();
}
