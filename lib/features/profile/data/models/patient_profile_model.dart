class PatientProfileModel {
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

  const PatientProfileModel({
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

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      gender: json['gender'] as String,
      height: (json['height'] as num).toInt(),
      currentWeight: (json['currentWeight'] as num).toDouble(),
      targetWeight: (json['targetWeight'] as num).toDouble(),
      activityLevel: json['activityLevel'] as String,
      goal: json['goal'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
