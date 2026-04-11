import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class ScanCtaButton extends StatelessWidget {
  const ScanCtaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/scan'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: 16.br,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: 12.p,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: 16.br,
              ),
              child: AppAssets.barcodeScanner.svg(width: 24, height: 24),
            ),
            16.hw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Barkod Oxut",
                    style: AppTextStyles.h3.copyWith(color: Colors.white),
                  ),
                  4.hs,
                  Text(
                    "Məhsulun kalorisini dərhal öyrən",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
