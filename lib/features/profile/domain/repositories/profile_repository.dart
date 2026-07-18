import '../../../auth/domain/entities/user_entity.dart';
import '../entities/about_us_entity.dart';
import '../entities/patient_profile_entity.dart';
import '../entities/terms_entity.dart';
import '../usecases/update_profile_usecase.dart';
import '../usecases/update_patient_profile_usecase.dart';

abstract class ProfileRepository {
  Future<TermsEntity> getTermsOfService();
  Future<TermsEntity> getPrivacyPolicy();
  Future<AboutUsEntity> getAboutUs();
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile(UpdateProfileParams params);
  Future<PatientProfileEntity> getPatientProfile();
  Future<PatientProfileEntity> updatePatientProfile(
    UpdatePatientProfileParams params,
  );
}
