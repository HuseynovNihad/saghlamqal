import '../../domain/entities/photo_product_entity.dart';
import '../../domain/entities/photo_scan_history_entity.dart';
import '../../domain/repositories/photo_scan_repository.dart';
import '../datasource/photo_scan_remote_data_source.dart';
import '../mappers/photo_product_mapper.dart';
import '../mappers/photo_scan_history_mapper.dart';

class PhotoScanRepositoryImpl implements PhotoScanRepository {
  final PhotoScanRemoteDataSource _dataSource;

  PhotoScanRepositoryImpl(this._dataSource);

  @override
  Future<PhotoProductEntity> analyzeImage(String imagePath) async {
    final model = await _dataSource.analyzeImage(imagePath);
    return PhotoProductMapper.toEntity(model);
  }

  @override
  Future<List<PhotoScanHistoryEntity>> getScanHistory() async {
    final models = await _dataSource.getScanHistory();
    return PhotoScanHistoryMapper.toEntityList(models);
  }

  @override
  Future<void> deleteScanHistory(String id) async {
    await _dataSource.deleteScanHistory(id);
  }

  @override
  Future<void> clearScanHistory() async {
    await _dataSource.clearScanHistory();
  }
}
