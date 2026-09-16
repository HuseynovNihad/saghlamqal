import '../entities/patient_diet_plan_entity.dart';
import '../repositories/dietitians_repository.dart';

class GetDietPlanHistoryUseCase {
  final DietitiansRepository _repository;

  const GetDietPlanHistoryUseCase(this._repository);

  Future<List<PatientDietPlanEntity>> call() {
    return _repository.getDietPlanHistory();
  }
}
