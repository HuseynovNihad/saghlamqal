class UserEntity {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;
  final int? age;
  final double? weight;
  final double? height;
  final String? gender;
  final String? activityLevel;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.birthday,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.activityLevel,
    this.isActive = true,
  });

  String? get name {
    final parts = [
      if (firstName != null && firstName!.isNotEmpty) firstName,
      if (lastName != null && lastName!.isNotEmpty) lastName,
    ];
    return parts.isEmpty ? null : parts.join(' ');
  }
}
