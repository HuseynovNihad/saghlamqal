import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../../../auth/data/models/response/user_model.dart';
import '../models/about_us_model.dart';
import '../models/patient_profile_model.dart';
import '../models/terms_model.dart';
import '../models/update_patient_profile_request_model.dart';
import '../models/update_profile_request_model.dart';

abstract class ProfileRemoteDataSource {
  Future<TermsModel> getTermsOfService();
  Future<TermsModel> getPrivacyPolicy();
  Future<AboutUsModel> getAboutUs();
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(UpdateProfileRequestModel request);
  Future<PatientProfileModel> getPatientProfile();
  Future<PatientProfileModel> updatePatientProfile(
    UpdatePatientProfileRequestModel request,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkManager _networkManager;

  const ProfileRemoteDataSourceImpl(this._networkManager);

  @override
  Future<TermsModel> getTermsOfService() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.termsOfService,
    );
    return TermsModel.fromJson(response.data!);
  }

  @override
  Future<TermsModel> getPrivacyPolicy() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.privacyPolicy,
    );
    return TermsModel.fromJson(response.data!);
  }

  @override
  Future<AboutUsModel> getAboutUs() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.aboutUs,
    );
    return AboutUsModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getMe,
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> updateProfile(UpdateProfileRequestModel request) async {
    final response = await _networkManager.patch<Map<String, dynamic>>(
      Endpoints.updateProfile,
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<PatientProfileModel> getPatientProfile() async {
    final response = await _networkManager.get<Map<String, dynamic>>(
      Endpoints.getPatientProfile,
    );
    return PatientProfileModel.fromJson(response.data!);
  }

  @override
  Future<PatientProfileModel> updatePatientProfile(
    UpdatePatientProfileRequestModel request,
  ) async {
    final response = await _networkManager.patch<Map<String, dynamic>>(
      Endpoints.updatePatientProfile,
      data: request.toJson(),
    );
    return PatientProfileModel.fromJson(response.data!);
  }
}
