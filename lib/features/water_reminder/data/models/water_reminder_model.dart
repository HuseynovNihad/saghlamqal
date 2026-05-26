import 'manual_reminder_model.dart';

class WaterReminderModel {
  final bool isEnabled;
  final List<int> scheduledHours;
  final List<ManualReminderModel> manualReminders;
  final int dailyGoalMl;
  final int drunkTodayMl;
  final String lastDrunkDate;

  const WaterReminderModel({
    required this.isEnabled,
    required this.scheduledHours,
    required this.manualReminders,
    this.dailyGoalMl = 2500,
    this.drunkTodayMl = 0,
    this.lastDrunkDate = '',
  });

  factory WaterReminderModel.fromJson(Map<String, dynamic> json) =>
      WaterReminderModel(
        isEnabled: json['is_enabled'] as bool? ?? false,
        scheduledHours:
            (json['scheduled_hours'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            const [7, 9, 11, 13, 15, 17, 19, 21],
        manualReminders:
            (json['manual_reminders'] as List<dynamic>?)
                ?.map(
                  (e) =>
                      ManualReminderModel.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            const [],
        dailyGoalMl: json['daily_goal_ml'] as int? ?? 2500,
        drunkTodayMl: json['drunk_today_ml'] as int? ?? 0,
        lastDrunkDate: json['last_drunk_date'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
    'is_enabled': isEnabled,
    'scheduled_hours': scheduledHours,
    'manual_reminders': manualReminders.map((m) => m.toJson()).toList(),
    'daily_goal_ml': dailyGoalMl,
    'drunk_today_ml': drunkTodayMl,
    'last_drunk_date': lastDrunkDate,
  };

  WaterReminderModel copyWith({
    bool? isEnabled,
    List<int>? scheduledHours,
    List<ManualReminderModel>? manualReminders,
    int? dailyGoalMl,
    int? drunkTodayMl,
    String? lastDrunkDate,
  }) => WaterReminderModel(
    isEnabled: isEnabled ?? this.isEnabled,
    scheduledHours: scheduledHours ?? this.scheduledHours,
    manualReminders: manualReminders ?? this.manualReminders,
    dailyGoalMl: dailyGoalMl ?? this.dailyGoalMl,
    drunkTodayMl: drunkTodayMl ?? this.drunkTodayMl,
    lastDrunkDate: lastDrunkDate ?? this.lastDrunkDate,
  );
}
