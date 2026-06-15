class PhotoScanHistoryModel {
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
  final String createdAt;

  const PhotoScanHistoryModel({
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

  factory PhotoScanHistoryModel.fromJson(Map<String, dynamic> json) {
    return PhotoScanHistoryModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      vitamins: json['vitamins'] as Map<String, dynamic>?,
      advice: json['advice'] as String?,
      isFood: json['is_food'] as bool? ?? false,
      servingSize: (json['serving_size'] as num?)?.toDouble(),
      servingUnit: json['serving_unit'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }
}
