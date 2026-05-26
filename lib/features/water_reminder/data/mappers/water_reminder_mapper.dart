import '../../domain/entities/manual_reminder_entity.dart';
import '../../domain/entities/water_reminder_entity.dart';
import '../models/manual_reminder_model.dart';
import '../models/water_reminder_model.dart';

class WaterReminderMapper {
  const WaterReminderMapper();

  WaterReminderEntity toEntity(WaterReminderModel model) => WaterReminderEntity(
    isEnabled: model.isEnabled,
    scheduledHours: model.scheduledHours,
    manualReminders: model.manualReminders
        .map(
          (m) => ManualReminderEntity(
            id: m.id,
            hour: m.hour,
            minute: m.minute,
            note: m.note,
          ),
        )
        .toList(),
    dailyGoalMl: model.dailyGoalMl,
    drunkTodayMl: model.drunkTodayMl,
    lastDrunkDate: model.lastDrunkDate,
  );

  WaterReminderModel toModel(WaterReminderEntity entity) => WaterReminderModel(
    isEnabled: entity.isEnabled,
    scheduledHours: entity.scheduledHours,
    manualReminders: entity.manualReminders
        .map(
          (e) => ManualReminderModel(
            id: e.id,
            hour: e.hour,
            minute: e.minute,
            note: e.note,
          ),
        )
        .toList(),
    dailyGoalMl: entity.dailyGoalMl,
    drunkTodayMl: entity.drunkTodayMl,
    lastDrunkDate: entity.lastDrunkDate,
  );
}
