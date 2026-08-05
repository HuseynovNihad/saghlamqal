class FavoriteItemModel {
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
  final int? servingSize;
  final String? servingUnit;
  final String createdAt;
  final bool isFavorite;
  final String? favoriteId;

  const FavoriteItemModel({
    required this.id,
    this.icon,
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
    this.isFavorite = true,
    this.favoriteId,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      calories: (json['calories'] as num?)?.toDouble(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      vitamins: json['vitamins'] as Map<String, dynamic>?,
      advice: (json['advice'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFood: json['is_food'] as bool? ?? false,
      servingSize: (json['serving_size'] as num?)?.toInt(),
      servingUnit: json['serving_unit'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String,
      isFavorite: (json['isFavorite'] as bool?) ?? true,
      favoriteId: (json['favoriteId'] as String?) ?? json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
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
    'icon': icon,
    'createdAt': createdAt,
    'isFavorite': isFavorite,
    'favoriteId': favoriteId,
  };
}
