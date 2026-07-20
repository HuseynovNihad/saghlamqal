class UpdatePatientProfileRequestModel {
  final String? birthday; // "1995-05-20" formatında (yyyy-MM-dd)
  final String? gender;
  final int? height;
  final double? currentWeight;
  final double? targetWeight;
  final String? activityLevel;
  final String? goal;

  const UpdatePatientProfileRequestModel({
    this.birthday,
    this.gender,
    this.height,
    this.currentWeight,
    this.targetWeight,
    this.activityLevel,
    this.goal,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (birthday != null) json['birthday'] = birthday;
    if (gender != null) json['gender'] = gender;
    if (height != null) json['height'] = height;
    if (currentWeight != null) json['currentWeight'] = currentWeight;
    if (targetWeight != null) json['targetWeight'] = targetWeight;
    if (activityLevel != null) json['activityLevel'] = activityLevel;
    if (goal != null) json['goal'] = goal;
    return json;
  }
}
