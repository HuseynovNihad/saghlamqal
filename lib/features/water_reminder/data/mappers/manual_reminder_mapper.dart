import '../../domain/entities/manual_reminder_entity.dart';
import '../models/manual_reminder_model.dart';

class ManualReminderMapper {
  const ManualReminderMapper();

  ManualReminderEntity toEntity(ManualReminderModel model) =>
      ManualReminderEntity(
        id: model.id,
        hour: model.hour,
        minute: model.minute,
        note: model.note,
      );

  ManualReminderModel toModel(ManualReminderEntity entity) =>
      ManualReminderModel(
        id: entity.id,
        hour: entity.hour,
        minute: entity.minute,
        note: entity.note,
      );

  List<ManualReminderEntity> toEntityList(List<ManualReminderModel> models) =>
      models.map(toEntity).toList();

  List<ManualReminderModel> toModelList(List<ManualReminderEntity> entities) =>
      entities.map(toModel).toList();
}
