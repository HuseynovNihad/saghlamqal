import '../../data/models/update_meal_check_in_params.dart';
import '../entities/daily_meal_check_ins_entity.dart';
import '../repositories/dietitians_repository.dart';

class UpdateMealCheckInUseCase {
  final DietitiansRepository _repository;

  const UpdateMealCheckInUseCase(this._repository);

  Future<MealCheckInEntity> call(UpdateMealCheckInParams params) {
    return _repository.updateMealCheckIn(params);
  }
}
