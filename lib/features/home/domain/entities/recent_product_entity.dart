import 'package:equatable/equatable.dart';

class RecentProductEntity extends Equatable {
  final String name;
  final String? imageUrl;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final Map<String, double?>? vitamins;
  final String advice;
  final bool isFood;

  const RecentProductEntity({
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

  @override
  List<Object?> get props => [
    name,
    imageUrl,
    calories,
    protein,
    carbs,
    fat,
    vitamins,
    advice,
    isFood,
  ];
}
