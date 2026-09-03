import '../../data/models/request/complete_profile_request.dart';
import '../../data/models/response/user_model.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileUsecase {
  final IAuthRepository _repository;

  const CompleteProfileUsecase(this._repository);

  Future<UserModel> call(CompleteProfileRequest request) {
    return _repository.completeProfile(request);
  }
}
