import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UploadAvatarUseCase {
  final ProfileRepository _repository;

  const UploadAvatarUseCase(this._repository);

  Future<UserEntity> call(String filePath) {
    return _repository.uploadAvatar(filePath);
  }
}
