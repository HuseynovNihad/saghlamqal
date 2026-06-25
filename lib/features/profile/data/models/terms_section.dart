class TermsSectionModel {
  final String section;
  final String text;

  const TermsSectionModel({required this.section, required this.text});

  factory TermsSectionModel.fromJson(Map<String, dynamic> json) =>
      TermsSectionModel(
        section: json['section'] as String,
        text: json['text'] as String,
      );
}
