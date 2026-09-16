import '../entities/patient_diet_plan_entity.dart';
import '../repositories/dietitians_repository.dart';

class GetActiveDietPlanUseCase {
  final DietitiansRepository _repository;

  const GetActiveDietPlanUseCase(this._repository);

  Future<PatientDietPlanEntity?> call() {
    return _repository.getActiveDietPlan();
  }
}
