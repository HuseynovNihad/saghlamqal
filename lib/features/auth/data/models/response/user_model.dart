import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.phoneNumber,
    super.firstName,
    super.lastName,
    super.avatar,
    super.birthday,
    super.age,
    super.weight,
    super.targetWeight,
    super.height,
    super.gender,
    super.activityLevel,
    super.goal,
    super.isActive,
    super.profileCompleted,
    super.patientCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['user'] as Map<String, dynamic>? ?? json;

    String? apiFirstName = data['firstName'] as String?;
    String? apiLastName = data['lastName'] as String?;

    if ((apiFirstName == null || apiFirstName.isEmpty) &&
        data['name'] != null) {
      final name = (data['name'] as String).trim();

      if (name.isNotEmpty) {
        final nameParts = name.split(RegExp(r'\s+'));

        apiFirstName = nameParts.first;

        if (nameParts.length > 1) {
          apiLastName = nameParts.sublist(1).join(' ');
        }
      }
    }

    return UserModel(
      id: data['id'].toString(),
      email: data['email'] as String,
      phoneNumber: data['phoneNumber'] as String?,
      firstName: apiFirstName,
      lastName: apiLastName,
      avatar: data['avatar'] as String?,
      birthday: data['birthday'] != null
          ? DateTime.tryParse(data['birthday'].toString())
          : null,
      age: data['age'] as int?,
      weight: (data['weight'] as num?)?.toDouble(),
      targetWeight: (data['targetWeight'] as num?)?.toDouble(),
      height: (data['height'] as num?)?.toDouble(),
      gender: data['gender'] as String?,
      activityLevel: data['activityLevel'] as String?,
      goal: data['goal'] as String?,
      isActive: data['isActive'] as bool? ?? true,
      profileCompleted: data['profileCompleted'] as bool? ?? false,
      patientCode: data['patientCode'] as String?,
    );
  }
}
