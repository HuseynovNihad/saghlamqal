import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
    super.birthday,
    super.age,
    super.weight,
    super.height,
    super.gender,
    super.activityLevel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['user'] as Map<String, dynamic>? ?? json;

    String? apiFirstName = data['firstName'] as String?;
    String? apiLastName = data['lastName'] as String?;

    if ((apiFirstName == null || apiFirstName.isEmpty) &&
        data['name'] != null) {
      final nameParts = (data['name'] as String).trim().split(' ');
      apiFirstName = nameParts.first;
      if (nameParts.length > 1) {
        apiLastName = nameParts.sublist(1).join(' ');
      }
    }

    return UserModel(
      id: data['id'].toString(),
      email: data['email'] as String,
      firstName: apiFirstName,
      lastName: apiLastName,
      birthday: data['birthday'] != null
          ? DateTime.tryParse(data['birthday'] as String)
          : null,
      age: data['age'] as int?,
      weight: (data['weight'] as num?)?.toDouble(),
      height: (data['height'] as num?)?.toDouble(),
      gender: data['gender'] as String?,
      activityLevel: data['activityLevel'] as String?,
    );
  }
}
