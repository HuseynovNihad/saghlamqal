import 'manual_reminder_entity.dart';

class WaterReminderEntity {
  final bool isEnabled;
  final List<int> scheduledHours;
  final List<ManualReminderEntity> manualReminders;
  final int dailyGoalMl;
  final int drunkTodayMl;
  final String lastDrunkDate;

  const WaterReminderEntity({
    required this.isEnabled,
    required this.scheduledHours,
    required this.manualReminders,
    this.dailyGoalMl = 2500,
    this.drunkTodayMl = 0,
    this.lastDrunkDate = '',
  });

  int get remainingMl => (dailyGoalMl - drunkTodayMl).clamp(0, dailyGoalMl);

  double get progressPercent => (drunkTodayMl / dailyGoalMl).clamp(0.0, 1.0);

  bool get goalReached => drunkTodayMl >= dailyGoalMl;

  String? get nextReminderTime {
    final now = DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;

    final allSlots = <int>[
      ...scheduledHours.map((h) => h * 60),
      ...manualReminders.map((r) => r.hour * 60 + r.minute),
    ]..sort();

    for (final slot in allSlots) {
      if (slot > currentMinutes) {
        final h = slot ~/ 60;
        final m = slot % 60;
        return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
      }
    }
    return null;
  }

  WaterReminderEntity copyWith({
    bool? isEnabled,
    List<int>? scheduledHours,
    List<ManualReminderEntity>? manualReminders,
    int? dailyGoalMl,
    int? drunkTodayMl,
    String? lastDrunkDate,
  }) => WaterReminderEntity(
    isEnabled: isEnabled ?? this.isEnabled,
    scheduledHours: scheduledHours ?? this.scheduledHours,
    manualReminders: manualReminders ?? this.manualReminders,
    dailyGoalMl: dailyGoalMl ?? this.dailyGoalMl,
    drunkTodayMl: drunkTodayMl ?? this.drunkTodayMl,
    lastDrunkDate: lastDrunkDate ?? this.lastDrunkDate,
  );
}
