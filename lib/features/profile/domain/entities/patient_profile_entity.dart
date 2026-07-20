class PatientProfileEntity {
  final String id;
  final String userId;
  final DateTime? birthday;
  final String? gender;
  final int? height;
  final double? currentWeight;
  final double? targetWeight;
  final String? activityLevel;
  final String? goal;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PatientProfileEntity({
    required this.id,
    required this.userId,
    this.birthday,
    this.gender,
    this.height,
    this.currentWeight,
    this.targetWeight,
    this.activityLevel,
    this.goal,
    required this.createdAt,
    required this.updatedAt,
  });
}
