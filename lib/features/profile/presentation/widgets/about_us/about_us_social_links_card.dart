import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/l10n/localization_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/social_links_entity.dart';
import 'about_us_social_button.dart';

class AboutUsSocialLinksCard extends StatelessWidget {
  const AboutUsSocialLinksCard({super.key, required this.socialLinks});

  final SocialLinksEntity socialLinks;

  Future<void> _launch(BuildContext context, String url) async {
    final trimmed = url.trim();
    final uri = Uri.tryParse(trimmed);

    if (uri == null) {
      _showError(context, context.l10n.aboutUsInvalidLink(trimmed));

      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        _showError(context, context.l10n.aboutUsLinkOpenFailed(trimmed));
      }
    } catch (error) {
      if (context.mounted) {
        _showError(context, context.l10n.aboutUsLinkError(error.toString()));
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
          label: context.l10n.aboutUsEmail,
          onTap: () => _launch(context, 'mailto:${socialLinks.email}'),
        ),

        12.ws,

        AboutUsSocialButton(
          imagePath: AppAssets.website,
          label: context.l10n.aboutUsWebsite,
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
