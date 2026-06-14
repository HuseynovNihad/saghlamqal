import '../../../ai_photo_scan/data/models/photo_product_model.dart';

class RecentProductModel {
  final String name;
  final String? imageUrl;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final Map<String, double?>? vitamins;
  final String advice;
  final bool isFood;

  const RecentProductModel({
    required this.name,
    this.imageUrl,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.vitamins,
    required this.advice,
    this.isFood = true,
  });

  factory RecentProductModel.fromJson(Map<String, dynamic> json) {
    final rawVitamins = json['vitamins'] as Map<String, dynamic>?;
    return RecentProductModel(
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      calories: json['calories'] as int,
      protein: json['protein'] as int,
      carbs: json['carbs'] as int,
      fat: json['fat'] as int,
      vitamins: rawVitamins?.map(
        (k, v) => MapEntry(k, (v as num?)?.toDouble()),
      ),
      advice: (json['advice'] as String?) ?? '',
      isFood: (json['is_food'] as bool?) ?? true,
    );
  }

  factory RecentProductModel.fromPhoto(PhotoProductModel photo) {
    return RecentProductModel(
      name: photo.name,
      calories: photo.calories?.round() ?? 0,
      protein: photo.protein?.round() ?? 0,
      carbs: photo.carbs?.round() ?? 0,
      fat: photo.fat?.round() ?? 0,
      vitamins: photo.vitamins,
      advice: photo.advice,
      isFood: photo.isFood,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'vitamins': vitamins,
      'advice': advice,
      'is_food': isFood,
    };
  }
}
