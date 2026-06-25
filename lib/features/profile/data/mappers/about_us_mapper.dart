import '../../domain/entities/about_us_entity.dart';
import '../../domain/entities/about_us_section_entity.dart';
import '../../domain/entities/social_links_entity.dart';
import '../models/about_us_model.dart';
import '../models/about_us_section_model.dart';
import '../models/social_links_model.dart';

extension AboutUsSectionMapper on AboutUsSectionModel {
  AboutUsSectionEntity toEntity() =>
      AboutUsSectionEntity(icon: icon, title: title, text: text);
}

extension SocialLinksMapper on SocialLinksModel {
  SocialLinksEntity toEntity() =>
      SocialLinksEntity(email: email, website: website, instagram: instagram);
}

extension AboutUsMapper on AboutUsModel {
  AboutUsEntity toEntity() => AboutUsEntity(
    appName: appName,
    version: version,
    description: description,
    sections: sections.map((e) => e.toEntity()).toList(),
    socialLinks: socialLinks.toEntity(),
    lastUpdated: lastUpdated,
  );
}
