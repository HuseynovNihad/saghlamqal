part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomeAddWaterPressed extends HomeEvent {
  const HomeAddWaterPressed();
}

final class HomeRecentProductsRequested extends HomeEvent {
  const HomeRecentProductsRequested();
}

final class HomeMealOfTheDayRequested extends HomeEvent {
  const HomeMealOfTheDayRequested();
}
