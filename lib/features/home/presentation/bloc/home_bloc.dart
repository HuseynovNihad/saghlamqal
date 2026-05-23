import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/daily_goal_entity.dart';
import '../../domain/entities/hydration_entity.dart';
import '../../domain/entities/meal_of_the_day_entity.dart';
import '../../domain/entities/recent_product_entity.dart';
import '../../domain/usecases/add_water_usecase.dart';
import '../../domain/usecases/get_daily_goal.dart';
import '../../domain/usecases/get_hydration_usecase.dart';
import '../../domain/usecases/get_meal_of_the_day_usecase.dart';
import '../../domain/usecases/get_recent_products_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDailyGoal _getDailyGoal;
  final GetHydration _getHydration;
  final AddWater _addWater;
  final GetRecentProductsUseCase _getRecentProducts;
  final GetMealOfTheDay _getMealOfTheDay;

  HomeBloc({
    required GetDailyGoal getDailyGoal,
    required GetHydration getHydration,
    required AddWater addWater,
    required GetRecentProductsUseCase getRecentProducts,
    required GetMealOfTheDay getMealOfTheDay,
  }) : _getDailyGoal = getDailyGoal,
       _getHydration = getHydration,
       _addWater = addWater,
       _getRecentProducts = getRecentProducts,
       _getMealOfTheDay = getMealOfTheDay,
       super(const HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeAddWaterPressed>(_onAddWaterPressed);
    on<HomeRecentProductsRequested>(_onRecentProductsRequested);
    on<HomeMealOfTheDayRequested>(_onMealOfTheDayRequested);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        _getDailyGoal(),
        _getHydration(),
        _getRecentProducts(),
        _getMealOfTheDay(),
      ]);

      emit(
        HomeLoaded(
          dailyGoal: results[0] as DailyGoalEntity,
          hydration: results[1] as HydrationEntity,
          recentProducts: results[2] as List<RecentProductEntity>,
          mealOfTheDay: results[3] as MealOfTheDayEntity,
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onAddWaterPressed(
    HomeAddWaterPressed event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    try {
      final hydration = await _addWater();
      emit(current.copyWith(hydration: hydration));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onRecentProductsRequested(
    HomeRecentProductsRequested event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    try {
      final recentProducts = await _getRecentProducts();
      emit(current.copyWith(recentProducts: recentProducts));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onMealOfTheDayRequested(
    HomeMealOfTheDayRequested event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    try {
      final mealOfTheDay = await _getMealOfTheDay();
      emit(current.copyWith(mealOfTheDay: mealOfTheDay));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
