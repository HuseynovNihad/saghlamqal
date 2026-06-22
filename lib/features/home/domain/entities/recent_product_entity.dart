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
  final String? advice;
  final bool isFood;
  final double? servingSize;
  final String? servingUnit;
  final DateTime createdAt;

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
  });

  @override
  List<Object?> get props => [
    id,
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
  ];
}
