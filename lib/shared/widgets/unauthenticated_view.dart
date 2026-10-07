import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/l10n/localization_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/utils/asset_extension.dart';
import '../../core/utils/radius_extension.dart';

class UnauthFeatureItem {
  const UnauthFeatureItem({required this.icon, required this.label});

  final String icon;
  final String label;
}

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView({
    super.key,
    required this.headerIcon,
    required this.title,
    required this.subtitle,
    required this.features,
  });

  final String headerIcon;
  final String title;
  final String subtitle;
  final List<UnauthFeatureItem> features;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: headerIcon.svg(
                  width: 36,
                  height: 36,
                  color: AppColors.primary,
                ),
              ),
            ),

            24.verticalSpace,

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(height: 1.3),
            ),

            12.verticalSpace,

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
            ),

            32.verticalSpace,

            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _FeatureRow(icon: feature.icon, label: feature.label),
              ),
            ),

            28.verticalSpace,

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.go(AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: 16.br),
                ),
                child: Text(
                  context.l10n.commonLogin,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            12.verticalSpace,

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  context.go(AppRoutes.register);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.borderColor),
                  shape: RoundedRectangleBorder(borderRadius: 16.br),
                ),
                child: Text(
                  context.l10n.commonRegister,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: 12.br,
          ),
          child: Center(
            child: icon.svg(
              width: 18,
              height: 18,
              color: const Color(0xFF888888),
            ),
          ),
        ),

        12.horizontalSpace,

        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.headline,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
