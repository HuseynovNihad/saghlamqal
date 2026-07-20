import 'dart:developer';

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
    on<HomeRefreshRecent>(_onRefreshRecent);
    on<HomeDailyGoalRequested>(_onDailyGoalRequested);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    DailyGoalEntity? dailyGoal;
    HydrationEntity? hydration;
    List<RecentProductEntity> recentProducts = [];
    MealOfTheDayEntity? mealOfTheDay;
    try {
      dailyGoal = await _getDailyGoal();
    } catch (e) {
      log('DailyGoal error: $e');
    }
    try {
      hydration = await _getHydration();
    } catch (e) {
      log('Hydration error: $e');
    }
    try {
      recentProducts = await _getRecentProducts();
    } catch (e) {
      log('RecentProducts error: $e');
    }
    try {
      mealOfTheDay = await _getMealOfTheDay();
    } catch (e) {
      log('MealOfTheDay error: $e');
    }

    emit(
      HomeLoaded(
        dailyGoal: dailyGoal ?? DailyGoalEntity.empty(),
        hydration: hydration ?? HydrationEntity.empty(),
        recentProducts: recentProducts,
        mealOfTheDay: mealOfTheDay,
      ),
    );
  }

  Future<void> _onAddWaterPressed(
    HomeAddWaterPressed event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    final addedLiters = event.amount;
    final newConsumed = (current.hydration.consumed + addedLiters).clamp(
      0.0,
      current.hydration.dailyGoal,
    );
    final newRemaining = (current.hydration.dailyGoal - newConsumed).clamp(
      0.0,
      current.hydration.dailyGoal,
    );
    final newPercentage = ((newConsumed / current.hydration.dailyGoal) * 100)
        .clamp(0.0, 100.0);

    final optimistic = HydrationEntity(
      dailyGoal: current.hydration.dailyGoal,
      consumed: newConsumed,
      remaining: newRemaining,
      percentage: newPercentage,
    );

    emit(current.copyWith(hydration: optimistic));

    try {
      final updated = await _addWater(event.amount);
      emit(current.copyWith(hydration: updated));
    } catch (_) {
      emit(current.copyWith(hydration: current.hydration));
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

  Future<void> _onRefreshRecent(
    HomeRefreshRecent event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    try {
      final recentProducts = await _getRecentProducts();
      emit(current.copyWith(recentProducts: recentProducts));
    } catch (e) {
      log('RefreshRecent error: $e');
    }
  }

  Future<void> _onDailyGoalRequested(
    HomeDailyGoalRequested event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    final results = await Future.wait([
      _getDailyGoal().catchError((e) {
        log('DailyGoalRequested error: $e');
        return current.dailyGoal;
      }),
      _getHydration().catchError((e) {
        log('HydrationRequested error: $e');
        return current.hydration;
      }),
    ]);

    emit(
      current.copyWith(
        dailyGoal: results[0] as DailyGoalEntity,
        hydration: results[1] as HydrationEntity,
      ),
    );
  }
}
