class WaterReminderState {
  final bool isEnabled;
  final bool permissionDenied;
  final String? nextReminderTime;

  const WaterReminderState({
    this.isEnabled = false,
    this.permissionDenied = false,
    this.nextReminderTime,
  });

  WaterReminderState copyWith({
    bool? isEnabled,
    bool? permissionDenied,
    String? nextReminderTime,
  }) => WaterReminderState(
    isEnabled: isEnabled ?? this.isEnabled,
    permissionDenied: permissionDenied ?? this.permissionDenied,
    nextReminderTime: nextReminderTime ?? this.nextReminderTime,
  );
}
