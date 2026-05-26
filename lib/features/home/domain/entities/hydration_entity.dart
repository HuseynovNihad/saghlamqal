import 'package:equatable/equatable.dart';

class HydrationEntity extends Equatable {
  final double tracked;
  final double recommended;
  final int addAmount;

  const HydrationEntity({
    required this.tracked,
    required this.recommended,
    required this.addAmount,
  });

  double get fillRatio => (tracked / recommended).clamp(0.0, 1.0);

  HydrationEntity addWater() {
    return HydrationEntity(
      tracked: (tracked + addAmount).clamp(0.0, recommended),
      recommended: recommended,
      addAmount: addAmount,
    );
  }

  @override
  List<Object?> get props => [tracked, recommended, addAmount];
}
