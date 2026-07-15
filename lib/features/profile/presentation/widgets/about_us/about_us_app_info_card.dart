import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class AboutUsAppInfoCard extends StatelessWidget {
  final String appName;
  final String version;
  final String description;

  const AboutUsAppInfoCard({
    super.key,
    required this.appName,
    required this.version,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 16.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        children: [
          AppAssets.appLogo.png(width: 90, height: 90, fit: BoxFit.cover),
          Text(
            appName,
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          6.hs,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'v$version',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          14.hs,
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(height: 1.55),
          ),
        ],
      ),
    );
  }
}
