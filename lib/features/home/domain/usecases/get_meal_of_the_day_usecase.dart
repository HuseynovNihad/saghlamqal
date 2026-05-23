import '../entities/meal_of_the_day_entity.dart';
import '../repositories/home_repository.dart';

class GetMealOfTheDay {
  final HomeRepository _repository;

  const GetMealOfTheDay(this._repository);

  Future<MealOfTheDayEntity> call() {
    return _repository.getMealOfTheDay();
  }
}
