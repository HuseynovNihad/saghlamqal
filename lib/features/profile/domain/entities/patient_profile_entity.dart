class PatientProfileEntity {
  final String id;
  final String userId;
  final DateTime birthday;
  final String gender;
  final int height;
  final double currentWeight;
  final double targetWeight;
  final String activityLevel;
  final String goal;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PatientProfileEntity({
    required this.id,
    required this.userId,
    required this.birthday,
    required this.gender,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.activityLevel,
    required this.goal,
    required this.createdAt,
    required this.updatedAt,
  });
}
