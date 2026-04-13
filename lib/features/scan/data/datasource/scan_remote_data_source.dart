import '../../../../core/network/open_food_facts_manager.dart';
import '../models/product_model.dart';

abstract class IScanRemoteDataSource {
  Future<ProductModel?> getProductByBarcode(String barcode);
}

class ScanRemoteDataSourceImpl implements IScanRemoteDataSource {
  final OpenFoodFactsManager _manager;

  ScanRemoteDataSourceImpl(this._manager);

  @override
  Future<ProductModel?> getProductByBarcode(String barcode) async {
    final response = await _manager.get<Map<String, dynamic>>(
      'product/$barcode.json',
    );

    final data = response.data;
    if (data == null || data['status'] != 1) return null;

    return ProductModel.fromJson(barcode, data);
  }
}
