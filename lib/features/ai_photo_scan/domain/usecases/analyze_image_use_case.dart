import '../entities/photo_product_entity.dart';
import '../repositories/photo_scan_repository.dart';

class AnalyzeImageUseCase {
  final PhotoScanRepository _repository;

  AnalyzeImageUseCase(this._repository);

  Future<PhotoProductEntity> call(String imagePath) {
    return _repository.analyzeImage(imagePath);
  }
}
