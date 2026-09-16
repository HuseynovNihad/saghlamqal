import '../entities/daily_meal_check_ins_entity.dart';
import '../repositories/dietitians_repository.dart';

class GetDietPlanCheckInsUseCase {
  final DietitiansRepository _repository;

  const GetDietPlanCheckInsUseCase(this._repository);

  Future<DailyMealCheckInsEntity> call(String date) {
    return _repository.getDietPlanCheckIns(date);
  }
}
