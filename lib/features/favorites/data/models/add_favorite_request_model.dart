class AddFavoriteRequestModel {
  final String name;
  final String? icon;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, dynamic>? vitamins;
  final List<String>? advice;
  final bool isFood;
  final int? servingSize;
  final String? servingUnit;

  const AddFavoriteRequestModel({
    required this.name,
    this.icon,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    this.advice,
    required this.isFood,
    this.servingSize,
    this.servingUnit,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'icon': icon,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'vitamins': vitamins,
    'advice': advice,
    'is_food': isFood,
    'serving_size': servingSize,
    'serving_unit': servingUnit,
  };
}
