class FavoriteItemEntity {
  final String id;
  final String foodId;
  final String name;
  final String? brand;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String? collectionId;
  final DateTime addedAt;

  const FavoriteItemEntity({
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

  FavoriteItemEntity copyWith({
    String? id,
    String? foodId,
    String? name,
    String? brand,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    String? collectionId,
    DateTime? addedAt,
  }) {
    return FavoriteItemEntity(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      collectionId: collectionId ?? this.collectionId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FavoriteItemEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
