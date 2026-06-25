import '../entities/about_us_entity.dart';
import '../repositories/profile_repository.dart';

class GetAboutUsUseCase {
  final ProfileRepository _repository;

  const GetAboutUsUseCase(this._repository);

  Future<AboutUsEntity> call() => _repository.getAboutUs();
}
