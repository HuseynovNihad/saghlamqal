import 'about_us_section_entity.dart';
import 'social_links_entity.dart';

class AboutUsEntity {
  final String appName;
  final String version;
  final String description;
  final List<AboutUsSectionEntity> sections;
  final SocialLinksEntity socialLinks;
  final DateTime lastUpdated;

  const AboutUsEntity({
    required this.appName,
    required this.version,
    required this.description,
    required this.sections,
    required this.socialLinks,
    required this.lastUpdated,
  });
}