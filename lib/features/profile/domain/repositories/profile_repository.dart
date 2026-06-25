import '../entities/about_us_entity.dart';
import '../entities/terms_entity.dart';

abstract class ProfileRepository {
  Future<TermsEntity> getTermsOfService();
  Future<TermsEntity> getPrivacyPolicy();
  Future<AboutUsEntity> getAboutUs();
}
