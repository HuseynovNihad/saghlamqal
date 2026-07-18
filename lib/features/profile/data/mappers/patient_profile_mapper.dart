import '../../domain/entities/patient_profile_entity.dart';
import '../models/patient_profile_model.dart';

extension PatientProfileModelMapper on PatientProfileModel {
  PatientProfileEntity toEntity() {
    return PatientProfileEntity(
      id: id,
      userId: userId,
      birthday: birthday,
      gender: gender,
      height: height,
      currentWeight: currentWeight,
      targetWeight: targetWeight,
      activityLevel: activityLevel,
      goal: goal,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
