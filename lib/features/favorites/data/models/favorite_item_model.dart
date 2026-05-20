class FavoriteItemModel {
  final String id;
  final String foodId;
  final String name;
  final String? brand;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String? collectionId;
  final String addedAt;

  const FavoriteItemModel({
    required this.id,
    required this.foodId,
    required this.name,
    this.brand,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.collectionId,
    required this.addedAt,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'] as String,
      foodId: json['food_id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      collectionId: json['collection_id'] as String?,
      addedAt: json['added_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'food_id': foodId,
    'name': name,
    'brand': brand,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'collection_id': collectionId,
    'added_at': addedAt,
  };
}
