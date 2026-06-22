import '../entities/hydration_entity.dart';
import '../repositories/home_repository.dart';

class AddWater {
  final HomeRepository _repository;

  const AddWater(this._repository);

  Future<HydrationEntity> call(double amount) => _repository.addWater(amount);
}
