import 'package:equatable/equatable.dart';

class MacroEntity extends Equatable {
  final String label;
  final int recommended;
  final String unit;

  const MacroEntity({
    required this.label,
    required this.recommended,
    required this.unit,
  });

  @override
  List<Object?> get props => [label, recommended, unit];
}
