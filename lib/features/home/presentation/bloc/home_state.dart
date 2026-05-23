part of 'home_bloc.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final DailyGoalEntity dailyGoal;
  final HydrationEntity hydration;
  final List<RecentProductEntity> recentProducts;
  final MealOfTheDayEntity? mealOfTheDay;

  const HomeLoaded({
    required this.dailyGoal,
    required this.hydration,
    this.recentProducts = const [],
    this.mealOfTheDay,
  });

  HomeLoaded copyWith({
    DailyGoalEntity? dailyGoal,
    HydrationEntity? hydration,
    List<RecentProductEntity>? recentProducts,
    MealOfTheDayEntity? mealOfTheDay,
  }) {
    return HomeLoaded(
      dailyGoal: dailyGoal ?? this.dailyGoal,
      hydration: hydration ?? this.hydration,
      recentProducts: recentProducts ?? this.recentProducts,
      mealOfTheDay: mealOfTheDay ?? this.mealOfTheDay,
    );
  }
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
