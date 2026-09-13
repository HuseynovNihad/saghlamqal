import '../repositories/dietitian_invites_repository.dart';

class AcceptDietitianInvite {
  final DietitianInvitesRepository repository;

  AcceptDietitianInvite(this.repository);

  Future<void> call(String inviteId) {
    return repository.acceptInvite(inviteId);
  }
}
