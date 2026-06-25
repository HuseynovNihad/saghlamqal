import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../models/about_us_model.dart';
import '../models/terms_model.dart';

abstract class ProfileRemoteDataSource {
  Future<TermsModel> getTermsOfService();
  Future<TermsModel> getPrivacyPolicy();
  Future<AboutUsModel> getAboutUs();
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
}
