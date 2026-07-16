class UserEntity {
  final String id;
  final String email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;
  final int? age;
  final double? weight;
  final double? targetWeight;
  final double? height;
  final String? gender;
  final String? activityLevel;
  final String? goal;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.birthday,
    this.age,
    this.weight,
    this.targetWeight,
    this.height,
    this.gender,
    this.activityLevel,
    this.goal,
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
