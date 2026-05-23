class PhotoProductEntity {
  final String name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String advice;
  final bool isFood;

  const PhotoProductEntity({
    required this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    required this.advice,
    this.isFood = true,
  });
}
