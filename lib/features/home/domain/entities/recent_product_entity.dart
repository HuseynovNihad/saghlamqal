import 'package:equatable/equatable.dart';

class RecentProductEntity extends Equatable {
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
  final DateTime createdAt;
  final bool isFavorite;
  final String? favoriteId;

  const RecentProductEntity({
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
    this.isFavorite = false,
    this.favoriteId,
  });

  RecentProductEntity copyWith({
    bool? isFavorite,
    String? favoriteId,
  }) {
    return RecentProductEntity(
      id: id,
      icon: icon,
      name: name,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      vitamins: vitamins,
      advice: advice,
      isFood: isFood,
      servingSize: servingSize,
      servingUnit: servingUnit,
      createdAt: createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteId: favoriteId ?? this.favoriteId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    icon,
    name,
    calories,
    protein,
    carbs,
    fat,
    vitamins,
    advice,
    isFood,
    servingSize,
    servingUnit,
    createdAt,
    isFavorite,
    favoriteId,
  ];
}