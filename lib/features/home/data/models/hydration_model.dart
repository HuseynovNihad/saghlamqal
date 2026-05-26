class HydrationModel {
  final double tracked;
  final double recommended;
  final int addAmount;

  const HydrationModel({
    required this.tracked,
    required this.recommended,
    required this.addAmount,
  });

  factory HydrationModel.fromJson(Map<String, dynamic> json) {
    return HydrationModel(
      tracked: (json['tracked'] as num).toDouble(),
      recommended: (json['recommended'] as num).toDouble(),
      addAmount: (json['add_amount'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tracked': tracked,
      'recommended': recommended,
      'add_amount': addAmount,
    };
  }
}
