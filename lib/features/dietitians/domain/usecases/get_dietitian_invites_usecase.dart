import '../entities/dietitian_invite_entity.dart';
import '../repositories/dietitians_repository.dart';

class GetDietitianInvitesUseCase {
  final DietitiansRepository _repository;

  const GetDietitianInvitesUseCase(this._repository);

  Future<List<DietitianInviteEntity>> call() {
    return _repository.getInvites();
  }
}
