import '../entities/hydration_entity.dart';
import '../repositories/home_repository.dart';

class GetHydration {
  final HomeRepository _repository;

  const GetHydration(this._repository);

  Future<HydrationEntity> call() => _repository.getHydration();
}
