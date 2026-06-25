import 'terms_section.dart';

class TermsModel {
  final String type;
  final String title;
  final List<TermsSectionModel> content;
  final DateTime lastUpdated;

  const TermsModel({
    required this.type,
    required this.title,
    required this.content,
    required this.lastUpdated,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    type: json['type'] as String,
    title: json['title'] as String,
    content: (json['content'] as List)
        .map((e) => TermsSectionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  );
}
