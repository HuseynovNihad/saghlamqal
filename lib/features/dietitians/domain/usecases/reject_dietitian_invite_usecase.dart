import '../repositories/dietitians_repository.dart';

class RejectDietitianInviteUseCase {
  final DietitiansRepository _repository;

  const RejectDietitianInviteUseCase(this._repository);

  Future<void> call(String inviteId) {
    return _repository.rejectInvite(inviteId);
  }
}
