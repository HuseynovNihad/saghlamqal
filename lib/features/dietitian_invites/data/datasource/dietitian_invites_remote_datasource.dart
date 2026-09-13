import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_manager.dart';
import '../models/dietitian_invite_model.dart';

abstract class DietitianInvitesRemoteDataSource {
  Future<List<DietitianInviteModel>> getInvites();

  Future<void> acceptInvite(String inviteId);

  Future<void> rejectInvite(String inviteId);
}

class DietitianInvitesRemoteDataSourceImpl
    implements DietitianInvitesRemoteDataSource {
  final NetworkManager networkManager;

  DietitianInvitesRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<List<DietitianInviteModel>> getInvites() async {
    final response = await networkManager.get<List<dynamic>>(
      Endpoints.getDietitianInvites,
    );

    final data = response.data;

    if (data == null) {
      return [];
    }

    return data
        .map(
          (item) => DietitianInviteModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> acceptInvite(String inviteId) async {
    await networkManager.patch(Endpoints.acceptDietitianInvite(inviteId));
  }

  @override
  Future<void> rejectInvite(String inviteId) async {
    await networkManager.patch(Endpoints.rejectDietitianInvite(inviteId));
  }
}
