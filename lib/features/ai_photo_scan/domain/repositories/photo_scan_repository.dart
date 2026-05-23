import '../entities/photo_product_entity.dart';

abstract class PhotoScanRepository {
  Future<PhotoProductEntity> analyzeImage(String imagePath);
}