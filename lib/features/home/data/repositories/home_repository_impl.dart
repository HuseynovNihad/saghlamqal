import '../../domain/entities/daily_goal_entity.dart';
import '../../domain/entities/hydration_entity.dart';
import '../../domain/entities/meal_of_the_day_entity.dart';
import '../../domain/entities/recent_product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_datasource.dart';
import '../mappers/daily_goal_mapper.dart';
import '../mappers/hydration_mapper.dart';
import '../mappers/meal_of_the_day_mapper.dart';
import '../mappers/recent_product_mapper.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<DailyGoalEntity> getDailyGoal() async {
    final model = await _remoteDataSource.getDailyGoal();
    return DailyGoalMapper.toEntity(model);
  }

  @override
  Future<HydrationEntity> getHydration() async {
    final model = await _remoteDataSource.getHydration();
    return HydrationMapper.toEntity(model);
  }

  @override
  Future<HydrationEntity> addWater() async {
    final model = await _remoteDataSource.addWater();
    return HydrationMapper.toEntity(model);
  }

  @override
  Future<List<RecentProductEntity>> getRecentProducts() async {
    final models = await _remoteDataSource.getRecentProducts();
    return models.map(RecentProductMapper.toEntity).toList();
  }

  @override
  Future<MealOfTheDayEntity> getMealOfTheDay() async {
    final model = await _remoteDataSource.getMealOfTheDay();
    return MealOfTheDayMapper.toEntity(model);
  }
}
