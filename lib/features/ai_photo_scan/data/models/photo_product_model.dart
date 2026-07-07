class PhotoProductModel {
  final String? icon;
  final String name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, double?>? vitamins;
  final List<String> advice;
  final bool isFood;
  final int? servingSize;
  final String? servingUnit;

  const PhotoProductModel({
    this.icon,
    required this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    required this.advice,
    this.isFood = true,
    this.servingSize,
    this.servingUnit,
  });

  factory PhotoProductModel.fromJson(Map<String, dynamic> json) {
    final rawVitamins = json['vitamins'] as Map<String, dynamic>?;
    return PhotoProductModel(
      icon: (json['icon'] as String?) ?? '🍽️',
      name: (json['name'] as String?) ?? 'Naməlum məhsul',
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      vitamins: rawVitamins?.map(
        (k, v) => MapEntry(k, (v as num?)?.toDouble()),
      ),
      advice:
          (json['advice'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isFood: (json['is_food'] as bool?) ?? true,
      servingSize: (json['serving_size'] as num?)?.toInt(),
      servingUnit: json['serving_unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'icon': icon,
    'name': name,
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
