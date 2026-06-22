import '../entities/daily_goal_entity.dart';
import '../entities/hydration_entity.dart';
import '../entities/meal_of_the_day_entity.dart';
import '../entities/recent_product_entity.dart';

abstract class HomeRepository {
  Future<DailyGoalEntity> getDailyGoal();
  Future<HydrationEntity> getHydration();
  Future<HydrationEntity> addWater(double amount);
  Future<List<RecentProductEntity>> getRecentProducts();
  Future<MealOfTheDayEntity> getMealOfTheDay();
}
