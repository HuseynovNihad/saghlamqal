import '../entities/product_entity.dart';

abstract class IScanRepository {
  Future<ProductEntity?> getProductByBarcode(String barcode);
}
