import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/social_links_entity.dart';
import 'about_us_social_button.dart';

class AboutUsSocialLinksCard extends StatelessWidget {
  final SocialLinksEntity socialLinks;

  const AboutUsSocialLinksCard({super.key, required this.socialLinks});

  Future<void> _launch(BuildContext context, String url) async {
    final trimmed = url.trim();
    final uri = Uri.tryParse(trimmed);

    if (uri == null) {
      _showError(context, 'Keçərsiz link: $trimmed');
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showError(context, 'Link açıla bilmədi: $trimmed');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Xəta baş verdi: $e');
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AboutUsSocialButton(
          imagePath: AppAssets.mail,
          label: 'E-poçt',
          onTap: () => _launch(context, 'mailto:${socialLinks.email}'),
        ),
        12.ws,
        AboutUsSocialButton(
          imagePath: AppAssets.website,
          label: 'Vebsayt',
          onTap: () => _launch(context, socialLinks.website),
        ),
        12.ws,
        AboutUsSocialButton(
          imagePath: AppAssets.instagram,
          label: 'Instagram',
          onTap: () => _launch(context, socialLinks.instagram),
        ),
      ],
    );
  }
}
