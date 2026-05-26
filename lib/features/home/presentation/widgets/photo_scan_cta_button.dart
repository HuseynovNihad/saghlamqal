import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/asset_extension.dart';

class PhotoScanCtaButton extends StatelessWidget {
  const PhotoScanCtaButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.22;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.photoScan),
      child: Container(
        width: double.infinity,
        height: cardHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
          gradient: const LinearGradient(
            colors: [Color(0xFFAAD7B7), Color(0xFFF5FAF6)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: cardHeight * 0.05,
              bottom: 0,
              child: AspectRatio(
                aspectRatio: 0.9,
                child: Image.asset(
                  AppAssets.food,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    flex: 60,
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Şəklini çək,\nkaloriləri öyrən',
                                  style: AppTextStyles.h1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.055,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Text(
                                  'Saniyələr içində \nkalorilərini öyrən',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.grey.shade600,
                                    fontSize: screenWidth * 0.032,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _ActionPillButton(screenWidth: screenWidth),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 40, child: SizedBox.shrink()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionPillButton extends StatelessWidget {
  final double screenWidth;
  const _ActionPillButton({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssets.photoCamera.svg(
            width: screenWidth * 0.04,
            height: screenWidth * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            'Kameranı aç',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.032,
            ),
          ),
        ],
      ),
    );
  }
}
