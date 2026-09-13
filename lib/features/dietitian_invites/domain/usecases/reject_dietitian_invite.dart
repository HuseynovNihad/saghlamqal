import '../repositories/dietitian_invites_repository.dart';

class RejectDietitianInvite {
  final DietitianInvitesRepository repository;

  RejectDietitianInvite(this.repository);

  Future<void> call(String inviteId) {
    return repository.rejectInvite(inviteId);
  }
}
