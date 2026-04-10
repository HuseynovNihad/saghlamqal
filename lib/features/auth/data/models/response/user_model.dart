import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    super.name,
    super.age,
    super.weight,
    super.height,
    super.gender,
    super.activityLevel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      name: json['name'],
      age: json['age'],
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      gender: json['gender'],
      activityLevel: json['activityLevel'],
    );
  }
}
