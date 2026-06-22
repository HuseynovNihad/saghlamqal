part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomeAddWaterPressed extends HomeEvent {
  final double amount;
  const HomeAddWaterPressed({required this.amount});
}

final class HomeRecentProductsRequested extends HomeEvent {
  const HomeRecentProductsRequested();
}

final class HomeMealOfTheDayRequested extends HomeEvent {
  const HomeMealOfTheDayRequested();
}

final class HomeRefreshRecent extends HomeEvent {
  const HomeRefreshRecent();
}
