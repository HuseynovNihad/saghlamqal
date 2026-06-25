import '../../domain/entities/about_us_entity.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';
import '../mappers/about_us_mapper.dart';
import '../mappers/terms_mapper.dart';

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
}
