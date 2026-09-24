class HealthActivityModel {
  final DateTime date;
  final int steps;
  final double? distanceMeters;
  final double? activeCalories;
  final String source;

  const HealthActivityModel({
    required this.date,
    required this.steps,
    required this.distanceMeters,
    required this.activeCalories,
    required this.source,
  });

  String get dateString {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Map<String, dynamic> toSyncJson() {
    return {
      'date': dateString,
      'steps': steps,
      if (distanceMeters != null) 'distanceMeters': distanceMeters,
      if (activeCalories != null) 'activeCalories': activeCalories,
      'source': source,
    };
  }
}
