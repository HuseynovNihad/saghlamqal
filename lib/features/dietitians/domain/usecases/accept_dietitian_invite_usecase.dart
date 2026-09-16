import '../repositories/dietitians_repository.dart';

class AcceptDietitianInviteUseCase {
  final DietitiansRepository _repository;

  const AcceptDietitianInviteUseCase(this._repository);

  Future<void> call(String inviteId) {
    return _repository.acceptInvite(inviteId);
  }
}
