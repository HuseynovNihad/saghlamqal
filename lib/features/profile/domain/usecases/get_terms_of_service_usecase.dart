import '../entities/terms_entity.dart';
import '../repositories/profile_repository.dart';

class GetTermsOfServiceUseCase {
  final ProfileRepository _repository;

  const GetTermsOfServiceUseCase(this._repository);

  Future<TermsEntity> call() => _repository.getTermsOfService();
}
