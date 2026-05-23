import 'package:equatable/equatable.dart';

import 'ingredient_entity.dart';

class MealOfTheDayEntity extends Equatable {
  final int id;
  final String tag;
  final String title;
  final String imageUrl;
  final int kcal;
  final int timeMinutes;
  final String description;
  final int protein;
  final int carbs;
  final int fat;
  final List<IngredientEntity> ingredients;
  final List<String> steps;
  final int servings;

  const MealOfTheDayEntity({
    required this.id,
    required this.tag,
    required this.title,
    required this.imageUrl,
    required this.kcal,
    required this.timeMinutes,
    required this.description,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.ingredients,
    required this.steps,
    required this.servings,
  });

  @override
  List<Object?> get props => [
    id,
    tag,
    title,
    imageUrl,
    kcal,
    timeMinutes,
    description,
    protein,
    carbs,
    fat,
    ingredients,
    steps,
    servings,
  ];
}
