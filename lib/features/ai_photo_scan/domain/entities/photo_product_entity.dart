class PhotoProductEntity {
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
  final String? icon;

  const PhotoProductEntity({
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
    this.icon,
  });
}
