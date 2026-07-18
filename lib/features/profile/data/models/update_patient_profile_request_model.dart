class UpdatePatientProfileRequestModel {
  final String birthday; // "1995-05-20" formatında (yyyy-MM-dd)
  final String gender;
  final int height;
  final double currentWeight;
  final double targetWeight;
  final String activityLevel;
  final String goal;

  const UpdatePatientProfileRequestModel({
    required this.birthday,
    required this.gender,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.activityLevel,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday,
      'gender': gender,
      'height': height,
      'currentWeight': currentWeight,
      'targetWeight': targetWeight,
      'activityLevel': activityLevel,
      'goal': goal,
    };
  }
}
