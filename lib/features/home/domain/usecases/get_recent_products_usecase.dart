import '../entities/recent_product_entity.dart';
import '../repositories/home_repository.dart';

class GetRecentProductsUseCase {
  final HomeRepository _repository;

  const GetRecentProductsUseCase(this._repository);

  Future<List<RecentProductEntity>> call() {
    return _repository.getRecentProducts();
  }
}
