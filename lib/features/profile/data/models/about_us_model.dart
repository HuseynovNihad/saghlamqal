import 'about_us_section_model.dart';
import 'social_links_model.dart';

class AboutUsModel {
  final String type;
  final String appName;
  final String version;
  final String description;
  final List<AboutUsSectionModel> sections;
  final SocialLinksModel socialLinks;
  final DateTime lastUpdated;

  const AboutUsModel({
    required this.type,
    required this.appName,
    required this.version,
    required this.description,
    required this.sections,
    required this.socialLinks,
    required this.lastUpdated,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    type: json['type'] as String,
    appName: json['appName'] as String,
    version: json['version'] as String,
    description: json['description'] as String,
    sections: (json['sections'] as List)
        .map((e) => AboutUsSectionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    socialLinks: SocialLinksModel.fromJson(
      json['socialLinks'] as Map<String, dynamic>,
    ),
    lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  );
}
