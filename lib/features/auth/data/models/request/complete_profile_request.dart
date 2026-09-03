class CompleteProfileRequest {
  final String phoneNumber;
  final DateTime birthday;
  final String gender;
  final double height;
  final double currentWeight;
  final double? targetWeight;
  final String activityLevel;
  final String goal;

  const CompleteProfileRequest({
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    required this.height,
    required this.currentWeight,
    this.targetWeight,
    required this.activityLevel,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'birthday': _formatDate(birthday),
      'gender': gender,
      'height': height,
      'currentWeight': currentWeight,
      if (targetWeight != null) 'targetWeight': targetWeight,
      'activityLevel': activityLevel,
      'goal': goal,
    };
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
