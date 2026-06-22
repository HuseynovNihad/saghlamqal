import 'package:equatable/equatable.dart';

class HydrationEntity extends Equatable {
  final double dailyGoal;
  final double consumed;
  final double remaining;
  final double percentage;

  const HydrationEntity({
    required this.dailyGoal,
    required this.consumed,
    required this.remaining,
    required this.percentage,
  });

  factory HydrationEntity.empty() {
    return const HydrationEntity(
      dailyGoal: 0,
      consumed: 0,
      remaining: 0,
      percentage: 0,
    );
  }

  double get safeFillRatio {
    if (dailyGoal <= 0) return 0;
    return (percentage / 100).clamp(0.0, 1.0);
  }

  double get fillRatio =>
      dailyGoal <= 0 ? 0 : (percentage / 100).clamp(0.0, 1.0);

  @override
  List<Object?> get props => [dailyGoal, consumed, remaining, percentage];
}
