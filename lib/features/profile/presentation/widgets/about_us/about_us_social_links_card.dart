import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/social_links_entity.dart';
import 'about_us_social_button.dart';

class AboutUsSocialLinksCard extends StatelessWidget {
  final SocialLinksEntity socialLinks;

  const AboutUsSocialLinksCard({super.key, required this.socialLinks});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // about_us_social_links_card.dart
        AboutUsSocialButton(
          imagePath: AppAssets.mail,
          label: 'E-poçt',
          onTap: () => _launch('mailto:${socialLinks.email}'),
        ),
        12.ws,
        AboutUsSocialButton(
          imagePath: AppAssets.website,
          label: 'Vebsayt',
          onTap: () => _launch(socialLinks.website),
        ),
        12.ws,
        AboutUsSocialButton(
          imagePath: AppAssets.instagram,
          label: 'Instagram',
          onTap: () => _launch(socialLinks.instagram),
        ),
      ],
    );
  }
}
