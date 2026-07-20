import '../entities/patient_profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdatePatientProfileParams {
  final DateTime? birthday;
  final String? gender;
  final int? height;
  final double? currentWeight;
  final double? targetWeight;
  final String? activityLevel;
  final String? goal;

  const UpdatePatientProfileParams({
    this.birthday,
    this.gender,
    this.height,
    this.currentWeight,
    this.targetWeight,
    this.activityLevel,
    this.goal,
  });
}

class UpdatePatientProfileUseCase {
  final ProfileRepository _repository;

  const UpdatePatientProfileUseCase(this._repository);

  Future<PatientProfileEntity> call(UpdatePatientProfileParams params) {
    return _repository.updatePatientProfile(params);
  }
}
