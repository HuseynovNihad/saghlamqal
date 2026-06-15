class PhotoScanHistoryEntity {
  final String id;
  final String? name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, dynamic>? vitamins;
  final String? advice;
  final bool isFood;
  final double? servingSize;
  final String? servingUnit;
  final DateTime createdAt;

  const PhotoScanHistoryEntity({
    required this.id,
    this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    this.advice,
    required this.isFood,
    this.servingSize,
    this.servingUnit,
    required this.createdAt,
  });
}
