import '../../domain/entities/meal_of_the_day_entity.dart';
import '../models/meal_of_the_day_model.dart';
import 'ingredient_mapper.dart';

class MealOfTheDayMapper {
  const MealOfTheDayMapper._();

  static MealOfTheDayEntity toEntity(MealOfTheDayModel model) {
    return MealOfTheDayEntity(
      id: model.id,
      tag: model.tag,
      title: model.title,
      imageUrl: model.imageUrl,
      kcal: model.kcal,
      timeMinutes: model.timeMinutes,
      description: model.description,
      protein: model.protein,
      carbs: model.carbs,
      fat: model.fat,
      ingredients: model.ingredients.map(IngredientMapper.toEntity).toList(),
      steps: model.steps,
      servings: model.servings,
    );
  }

  static MealOfTheDayModel toModel(MealOfTheDayEntity entity) {
    return MealOfTheDayModel(
      id: entity.id,
      tag: entity.tag,
      title: entity.title,
      imageUrl: entity.imageUrl,
      kcal: entity.kcal,
      timeMinutes: entity.timeMinutes,
      description: entity.description,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      ingredients: entity.ingredients.map(IngredientMapper.toModel).toList(),
      steps: entity.steps,
      servings: entity.servings,
    );
  }
}
