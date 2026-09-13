import '../entities/dietitian_invite_entity.dart';

abstract class DietitianInvitesRepository {
  Future<List<DietitianInviteEntity>> getInvites();

  Future<void> acceptInvite(String inviteId);

  Future<void> rejectInvite(String inviteId);
}
