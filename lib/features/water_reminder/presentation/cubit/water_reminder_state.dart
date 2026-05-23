class WaterReminderState {
  final bool isEnabled;
  final bool permissionDenied;

  const WaterReminderState({
    this.isEnabled = false,
    this.permissionDenied = false,
  });

  WaterReminderState copyWith({bool? isEnabled, bool? permissionDenied}) {
    return WaterReminderState(
      isEnabled: isEnabled ?? this.isEnabled,
      permissionDenied: permissionDenied ?? this.permissionDenied,
    );
  }
}
