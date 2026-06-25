import 'package:flutter/material.dart';

import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/about_us_entity.dart';
import 'about_us_app_info_card.dart';
import 'about_us_section_card.dart';
import 'about_us_social_links_card.dart';

class AboutUsContent extends StatelessWidget {
  final AboutUsEntity aboutUs;

  const AboutUsContent({super.key, required this.aboutUs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        AboutUsAppInfoCard(
          appName: aboutUs.appName,
          version: aboutUs.version,
          description: aboutUs.description,
        ),
        24.hs,
        ...aboutUs.sections.map((s) => AboutUsSectionCard(section: s)),
        24.hs,
        AboutUsSocialLinksCard(socialLinks: aboutUs.socialLinks),
        32.hs,
      ],
    );
  }
}