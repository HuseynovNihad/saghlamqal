class ManualReminderEntity {
  final String id;
  final int hour;
  final int minute;
  final String? note;

  const ManualReminderEntity({
    required this.id,
    required this.hour,
    required this.minute,
    this.note,
  });

  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
