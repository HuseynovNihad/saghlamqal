class DietitianInviteEntity {
  final String id;
  final String status;
  final DateTime invitedAt;
  final DietitianInviteInfoEntity dietitian;

  const DietitianInviteEntity({
    required this.id,
    required this.status,
    required this.invitedAt,
    required this.dietitian,
  });
}

class DietitianInviteInfoEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String title;
  final String? profilePhoto;
  final String? clinicName;
  final String? city;

  const DietitianInviteInfoEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    this.profilePhoto,
    this.clinicName,
    this.city,
  });

  String get fullName => '$firstName $lastName'.trim();

  String get initials {
    final first = firstName.trim();
    final last = lastName.trim();

    final firstInitial = first.isNotEmpty ? first[0] : '';
    final lastInitial = last.isNotEmpty ? last[0] : '';

    return '$firstInitial$lastInitial'.toUpperCase();
  }
}
