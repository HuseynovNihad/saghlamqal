import '../../domain/entities/dietitian_invite_entity.dart';
import '../models/dietitian_invite_model.dart';

class DietitianInviteMapper {
  DietitianInviteMapper._();

  static DietitianInviteEntity toEntity(DietitianInviteModel model) {
    return DietitianInviteEntity(
      id: model.id,
      status: model.status,
      invitedAt: model.invitedAt,
      dietitian: DietitianInviteInfoEntity(
        id: model.dietitian.id,
        firstName: model.dietitian.firstName,
        lastName: model.dietitian.lastName,
        title: model.dietitian.title,
        profilePhoto: model.dietitian.profilePhoto,
        clinicName: model.dietitian.clinicName,
        city: model.dietitian.city,
      ),
    );
  }

  static List<DietitianInviteEntity> toEntityList(
    List<DietitianInviteModel> models,
  ) {
    return models.map(toEntity).toList();
  }
}
