class ManualReminderModel {
  final String id;
  final int hour;
  final int minute;
  final String? note;

  const ManualReminderModel({
    required this.id,
    required this.hour,
    required this.minute,
    this.note,
  });

  factory ManualReminderModel.fromJson(Map<String, dynamic> json) =>
      ManualReminderModel(
        id: json['id'] as String,
        hour: json['hour'] as int,
        minute: json['minute'] as int,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'hour': hour,
    'minute': minute,
    if (note != null) 'note': note,
  };
}
