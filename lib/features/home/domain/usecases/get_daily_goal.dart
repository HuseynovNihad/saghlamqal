import '../entities/daily_goal_entity.dart';
import '../repositories/home_repository.dart';

class GetDailyGoal {
  final HomeRepository _repository;

  const GetDailyGoal(this._repository);

  Future<DailyGoalEntity> call() => _repository.getDailyGoal();
}
