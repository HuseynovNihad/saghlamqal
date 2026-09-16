class MyDietitianEntity {
  final String id;
  final String status;
  final DateTime? acceptedAt;
  final DateTime createdAt;
  final DietitianInfoEntity dietitian;

  const MyDietitianEntity({
    required this.id,
    required this.status,
    required this.acceptedAt,
    required this.createdAt,
    required this.dietitian,
  });
}

class DietitianInfoEntity {
  final String id;
  final String userId;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? title;
  final String? clinicName;
  final String? profilePhoto;
  final double rating;
  final int reviewCount;

  const DietitianInfoEntity({
    required this.id,
    required this.userId,
    this.firstName,
    this.lastName,
    this.avatar,
    this.title,
    this.clinicName,
    this.profilePhoto,
    required this.rating,
    required this.reviewCount,
  });

  String get fullName {
    final parts = [
      if (firstName != null && firstName!.trim().isNotEmpty) firstName!.trim(),
      if (lastName != null && lastName!.trim().isNotEmpty) lastName!.trim(),
    ];

    return parts.isEmpty ? 'Dietoloq' : parts.join(' ');
  }

  String? get imageUrl {
    if (profilePhoto != null && profilePhoto!.trim().isNotEmpty) {
      return profilePhoto;
    }

    if (avatar != null && avatar!.trim().isNotEmpty) {
      return avatar;
    }

    return null;
  }
}
