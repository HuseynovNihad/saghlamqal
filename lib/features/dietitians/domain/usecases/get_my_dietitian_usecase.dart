import '../entities/my_dietitian_entity.dart';
import '../repositories/dietitians_repository.dart';

class GetMyDietitianUseCase {
  final DietitiansRepository _repository;

  const GetMyDietitianUseCase(this._repository);

  Future<MyDietitianEntity?> call() {
    return _repository.getMyDietitian();
  }
}
