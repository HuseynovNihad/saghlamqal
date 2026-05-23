class PhotoProductModel {
  final String name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String advice;
  final bool isFood;

  const PhotoProductModel({
    required this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    required this.advice,
    this.isFood = true,
  });

  factory PhotoProductModel.fromJson(Map<String, dynamic> json) {
    return PhotoProductModel(
      name: (json['name'] as String?) ?? 'Naməlum məhsul',
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      advice: (json['advice'] as String?) ?? '',
      isFood: (json['is_food'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'advice': advice,
    'is_food': isFood,
  };
}
