import '../../domain/entities/photo_product_entity.dart';
import '../../domain/repositories/photo_scan_repository.dart';
import '../datasource/photo_scan_remote_data_source.dart';
import '../mappers/photo_product_mapper.dart';

class PhotoScanRepositoryImpl implements PhotoScanRepository {
  final PhotoScanRemoteDataSource _dataSource;

  PhotoScanRepositoryImpl(this._dataSource);

  @override
  Future<PhotoProductEntity> analyzeImage(String imagePath) async {
    final model = await _dataSource.analyzeImage(imagePath);
    return PhotoProductMapper.toEntity(model);
  }
}
