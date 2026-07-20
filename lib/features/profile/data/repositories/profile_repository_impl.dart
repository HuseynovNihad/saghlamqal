import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/about_us_entity.dart';
import '../../domain/entities/patient_profile_entity.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/update_patient_profile_usecase.dart';
import '../datasource/profile_remote_datasource.dart';
import '../mappers/about_us_mapper.dart';
import '../mappers/patient_profile_mapper.dart';
import '../mappers/terms_mapper.dart';
import '../models/update_patient_profile_request_model.dart';
import '../models/update_profile_request_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  const ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<TermsEntity> getTermsOfService() async {
    final model = await _remoteDataSource.getTermsOfService();
    return model.toEntity();
  }

  @override
  Future<TermsEntity> getPrivacyPolicy() async {
    final model = await _remoteDataSource.getPrivacyPolicy();
    return model.toEntity();
  }

  @override
  Future<AboutUsEntity> getAboutUs() async {
    final model = await _remoteDataSource.getAboutUs();
    return model.toEntity();
  }

  @override
  Future<UserEntity> getProfile() async {
    return _remoteDataSource.getProfile();
  }

  @override
  Future<UserEntity> updateProfile(UpdateProfileParams params) async {
    final request = UpdateProfileRequestModel(
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
    );
    return _remoteDataSource.updateProfile(request);
  }

  @override
  Future<PatientProfileEntity> getPatientProfile() async {
    final model = await _remoteDataSource.getPatientProfile();
    return model.toEntity();
  }

  @override
  Future<PatientProfileEntity> updatePatientProfile(
    UpdatePatientProfileParams params,
  ) async {
    final request = UpdatePatientProfileRequestModel(
      birthday: _formatDate(params.birthday),
      gender: params.gender,
      height: params.height,
      currentWeight: params.currentWeight,
      targetWeight: params.targetWeight,
      activityLevel: params.activityLevel,
      goal: params.goal,
    );
    final model = await _remoteDataSource.updatePatientProfile(request);
    return model.toEntity();
  }

  String? _formatDate(DateTime? date) {
    if (date == null) return null;
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
