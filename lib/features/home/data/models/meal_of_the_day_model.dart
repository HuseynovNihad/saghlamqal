import 'ingredient_model.dart';

class MealOfTheDayModel {
  final int? id;
  final String? tag;
  final String? title;
  final String? imageUrl;
  final int? kcal;
  final int? timeMinutes;
  final String? description;
  final int? protein;
  final int? carbs;
  final int? fat;
  final List<IngredientModel>? ingredients;
  final List<String>? steps;
  final int? servings;

  const MealOfTheDayModel({
    this.id,
    this.tag,
    this.title,
    this.imageUrl,
    this.kcal,
    this.timeMinutes,
    this.description,
    this.protein,
    this.carbs,
    this.fat,
    this.ingredients,
    this.steps,
    this.servings,
  });

  factory MealOfTheDayModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const MealOfTheDayModel();
    }

    return MealOfTheDayModel(
      id: json['id'] as int?,
      tag: json['tag'] as String?,
      title: json['title'] as String?,
      imageUrl: json['image_url'] as String?,
      kcal: json['kcal'] as int?,
      timeMinutes: json['time_minutes'] as int?,
      description: json['description'] as String?,
      protein: json['protein'] as int?,
      carbs: json['carbs'] as int?,
      fat: json['fat'] as int?,
      ingredients: (json['ingredients'] as List?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List?)?.map((e) => e.toString()).toList(),
      servings: json['servings'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'title': title,
      'image_url': imageUrl,
      'kcal': kcal,
      'time_minutes': timeMinutes,
      'description': description,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'ingredients': ingredients?.map((e) => e.toJson()).toList(),
      'steps': steps,
      'servings': servings,
    };
  }
}
