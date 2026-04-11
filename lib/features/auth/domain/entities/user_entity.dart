class UserEntity {
  final String id;
  final String email;
  final String? name;
  final DateTime? birthday;
  final int? age;
  final double? weight;
  final double? height;
  final String? gender;
  final String? activityLevel;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.birthday,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.activityLevel,
  });
}
