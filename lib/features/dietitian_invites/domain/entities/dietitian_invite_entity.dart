import 'package:equatable/equatable.dart';

class DietitianInviteEntity extends Equatable {
  final String id;
  final String status;
  final DateTime invitedAt;
  final DietitianInfoEntity dietitian;

  const DietitianInviteEntity({
    required this.id,
    required this.status,
    required this.invitedAt,
    required this.dietitian,
  });

  @override
  List<Object?> get props => [id, status, invitedAt, dietitian];
}

class DietitianInfoEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String title;
  final String? profilePhoto;
  final String? clinicName;
  final String? city;

  const DietitianInfoEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    this.profilePhoto,
    this.clinicName,
    this.city,
  });

  String get fullName => '$firstName $lastName'.trim();

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    title,
    profilePhoto,
    clinicName,
    city,
  ];
}
