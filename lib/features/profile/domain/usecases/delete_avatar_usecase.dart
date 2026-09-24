import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class DeleteAvatarUseCase {
  final ProfileRepository _repository;

  const DeleteAvatarUseCase(this._repository);

  Future<UserEntity> call() {
    return _repository.deleteAvatar();
  }
}
