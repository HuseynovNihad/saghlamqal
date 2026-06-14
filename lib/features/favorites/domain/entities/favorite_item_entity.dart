class FavoriteItemEntity {
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

  const FavoriteItemEntity({
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

  FavoriteItemEntity copyWith({
    String? id,
    String? name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    Map<String, dynamic>? vitamins,
    String? advice,
    bool? isFood,
    double? servingSize,
    String? servingUnit,
    DateTime? createdAt,
  }) {
    return FavoriteItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      vitamins: vitamins ?? this.vitamins,
      advice: advice ?? this.advice,
      isFood: isFood ?? this.isFood,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FavoriteItemEntity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
