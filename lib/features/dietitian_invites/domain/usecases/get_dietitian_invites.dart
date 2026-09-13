import '../entities/dietitian_invite_entity.dart';
import '../repositories/dietitian_invites_repository.dart';

class GetDietitianInvites {
  final DietitianInvitesRepository repository;

  GetDietitianInvites(this.repository);

  Future<List<DietitianInviteEntity>> call() {
    return repository.getInvites();
  }
}
