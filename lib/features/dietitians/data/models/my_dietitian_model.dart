import '../../domain/entities/my_dietitian_entity.dart';

class MyDietitianModel extends MyDietitianEntity {
  const MyDietitianModel({
    required super.id,
    required super.status,
    required super.acceptedAt,
    required super.createdAt,
    required super.dietitian,
  });

  factory MyDietitianModel.fromJson(Map<String, dynamic> json) {
    return MyDietitianModel(
      id: json['id'].toString(),
      status: json['status']?.toString() ?? '',
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.tryParse(json['acceptedAt'].toString())
          : null,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      dietitian: DietitianInfoModel.fromJson(
        json['dietitian'] as Map<String, dynamic>,
      ),
    );
  }
}

class DietitianInfoModel extends DietitianInfoEntity {
  const DietitianInfoModel({
    required super.id,
    required super.userId,
    super.firstName,
    super.lastName,
    super.avatar,
    super.title,
    super.clinicName,
    super.profilePhoto,
    required super.rating,
    required super.reviewCount,
  });

  factory DietitianInfoModel.fromJson(Map<String, dynamic> json) {
    return DietitianInfoModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
      title: json['title'] as String?,
      clinicName: json['clinicName'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
    );
  }
}
