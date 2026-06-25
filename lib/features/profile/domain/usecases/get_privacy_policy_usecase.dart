import '../entities/terms_entity.dart';
import '../repositories/profile_repository.dart';

class GetPrivacyPolicyUseCase {
  final ProfileRepository _repository;

  const GetPrivacyPolicyUseCase(this._repository);

  Future<TermsEntity> call() => _repository.getPrivacyPolicy();
}
