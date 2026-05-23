import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String name;
  final String amount;

  const IngredientEntity({
    required this.name,
    required this.amount,
  });

  @override
  List<Object?> get props => [name, amount];
}