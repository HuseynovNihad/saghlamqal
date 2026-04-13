import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/i_scan_repository.dart';
import '../datasource/scan_remote_data_source.dart';

class ScanRepository implements IScanRepository {
  final IScanRemoteDataSource _remoteDataSource;

  ScanRepository(this._remoteDataSource);

  @override
  Future<ProductEntity?> getProductByBarcode(String barcode) async {
    try {
      return await _remoteDataSource.getProductByBarcode(barcode);
    } on Exception {
      rethrow;
    }
  }
}
