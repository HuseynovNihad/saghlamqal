import '../../domain/entities/dietitian_invite_entity.dart';
import '../../domain/repositories/dietitian_invites_repository.dart';
import '../datasource/dietitian_invites_remote_datasource.dart';

class DietitianInvitesRepositoryImpl implements DietitianInvitesRepository {
  final DietitianInvitesRemoteDataSource remoteDataSource;

  DietitianInvitesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DietitianInviteEntity>> getInvites() async {
    return await remoteDataSource.getInvites();
  }

  @override
  Future<void> acceptInvite(String inviteId) async {
    await remoteDataSource.acceptInvite(inviteId);
  }

  @override
  Future<void> rejectInvite(String inviteId) async {
    await remoteDataSource.rejectInvite(inviteId);
  }
}
