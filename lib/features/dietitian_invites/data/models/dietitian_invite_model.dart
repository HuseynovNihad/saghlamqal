import '../../domain/entities/dietitian_invite_entity.dart';

class DietitianInviteModel extends DietitianInviteEntity {
  const DietitianInviteModel({
    required super.id,
    required super.status,
    required super.invitedAt,
    required super.dietitian,
  });

  factory DietitianInviteModel.fromJson(Map<String, dynamic> json) {
    return DietitianInviteModel(
      id: json['id'] as String,
      status: json['status'] as String,
      invitedAt: DateTime.parse(json['invitedAt'] as String),
      dietitian: DietitianInfoModel.fromJson(
        json['dietitian'] as Map<String, dynamic>,
      ),
    );
  }
}

class DietitianInfoModel extends DietitianInfoEntity {
  const DietitianInfoModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.title,
    super.profilePhoto,
    super.clinicName,
    super.city,
  });

  factory DietitianInfoModel.fromJson(Map<String, dynamic> json) {
    return DietitianInfoModel(
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
