class DietitianInviteModel {
  final String id;
  final String status;
  final DateTime invitedAt;
  final DietitianInviteInfoModel dietitian;

  const DietitianInviteModel({
    required this.id,
    required this.status,
    required this.invitedAt,
    required this.dietitian,
  });

  factory DietitianInviteModel.fromJson(Map<String, dynamic> json) {
    return DietitianInviteModel(
      id: json['id'] as String,
      status: json['status'] as String,
      invitedAt: DateTime.parse(json['invitedAt'] as String),
      dietitian: DietitianInviteInfoModel.fromJson(
        json['dietitian'] as Map<String, dynamic>,
      ),
    );
  }
}

class DietitianInviteInfoModel {
  final String id;
  final String firstName;
  final String lastName;
  final String title;
  final String? profilePhoto;
  final String? clinicName;
  final String? city;

  const DietitianInviteInfoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    this.profilePhoto,
    this.clinicName,
    this.city,
  });

  factory DietitianInviteInfoModel.fromJson(Map<String, dynamic> json) {
    return DietitianInviteInfoModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      profilePhoto: json['profilePhoto'] as String?,
      clinicName: json['clinicName'] as String?,
      city: json['city'] as String?,
    );
  }
}
