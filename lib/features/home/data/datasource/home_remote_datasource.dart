import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../models/daily_goal_model.dart';
import '../models/hydration_model.dart';
import '../models/meal_of_the_day_model.dart';
import '../models/recent_product_model.dart';

abstract class HomeRemoteDataSource {
  Future<DailyGoalModel> getDailyGoal();
  Future<HydrationModel> getHydration();
  Future<HydrationModel> addWater(int amount);
  Future<List<RecentProductModel>> getRecentProducts();
  Future<MealOfTheDayModel> getMealOfTheDay();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkManager _networkManager;

  const HomeRemoteDataSourceImpl(this._networkManager);

  @override
  Future<DailyGoalModel> getDailyGoal() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getDailyGoal,
    );
    return DailyGoalModel.fromJson(response.data!);
  }

  @override
  Future<HydrationModel> getHydration() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getHydration,
    );
    return HydrationModel.fromJson(response.data!);
  }

  @override
  Future<HydrationModel> addWater(int amount) async {
    final response = await _networkManager.post<Map<String, dynamic>>(
      Endpoints.addWater,
      data: {'amount': amount},
    );
    return HydrationModel.fromJson(response.data!);
  }

  @override
  Future<List<RecentProductModel>> getRecentProducts() async {
    final response = await _networkManager.get<List<dynamic>>(
      Endpoints.getRecentProducts,
    );
    return (response.data!)
        .map((e) => RecentProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MealOfTheDayModel> getMealOfTheDay() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getMealOfTheDay,
    );
    return MealOfTheDayModel.fromJson(response.data!);
  }
}
