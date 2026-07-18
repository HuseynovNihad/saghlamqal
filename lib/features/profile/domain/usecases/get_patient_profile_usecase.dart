import '../entities/patient_profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetPatientProfileUseCase {
  final ProfileRepository _repository;

  const GetPatientProfileUseCase(this._repository);

  Future<PatientProfileEntity> call() {
    return _repository.getPatientProfile();
  }
}
