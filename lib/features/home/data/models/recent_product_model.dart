import '../../../ai_photo_scan/data/models/photo_product_model.dart';

class RecentProductModel {
  final String id;
  final String? icon;
  final String? name;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final Map<String, dynamic>? vitamins;
  final List<String>? advice;
  final bool isFood;
  final double? servingSize;
  final String? servingUnit;
  final String createdAt;

  const RecentProductModel({
    required this.id,
    this.icon,
    this.name,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.vitamins,
    this.advice,
    this.isFood = true,
    this.servingSize,
    this.servingUnit,
    required this.createdAt,
  });

  factory RecentProductModel.fromJson(Map<String, dynamic> json) {
    return RecentProductModel(
      id: json['id'] as String,
      icon: json['icon'] as String?,
      name: json['name'] as String?,
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      vitamins: json['vitamins'] as Map<String, dynamic>?,
      advice: (json['advice'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isFood: (json['is_food'] as bool?) ?? true,
      servingSize: (json['serving_size'] as num?)?.toDouble(),
      servingUnit: json['serving_unit'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }

  factory RecentProductModel.fromPhoto(PhotoProductModel photo) {
    return RecentProductModel(
      id: '',
      icon: photo.icon,
      name: photo.name,
      calories: photo.calories,
      protein: photo.protein,
      carbs: photo.carbs,
      fat: photo.fat,
      vitamins: photo.vitamins,
      advice: photo.advice,
      isFood: photo.isFood,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'createdAt': createdAt,
    };
  }
}
