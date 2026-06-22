class HydrationModel {
  final double dailyGoal;
  final double consumed;
  final double remaining;
  final double percentage;

  const HydrationModel({
    required this.dailyGoal,
    required this.consumed,
    required this.remaining,
    required this.percentage,
  });

  factory HydrationModel.fromJson(Map<String, dynamic> json) {
    return HydrationModel(
      dailyGoal: (json['dailyGoal'] as num).toDouble(),
      consumed: (json['consumed'] as num).toDouble(),
      remaining: (json['remaining'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyGoal': dailyGoal,
      'consumed': consumed,
      'remaining': remaining,
      'percentage': percentage,
    };
  }
}
