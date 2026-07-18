import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  const UpdateProfileUseCase(this._repository);

  Future<UserEntity> call(UpdateProfileParams params) {
    return _repository.updateProfile(params);
  }
}
