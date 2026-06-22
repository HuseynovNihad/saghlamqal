import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';
import 'package:kalori_tracker/core/utils/radius_extension.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class GuestPreviewSection extends StatelessWidget {
  const GuestPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 24.p,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3A8F), Color(0xFF2B5CE6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: 20.br,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sağlıqlı həyat\nsənin əlindədir.',
            style: AppTextStyles.h2.copyWith(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          24.hs,
          const _FeatureItem(
            iconAsset: AppAssets.trackChanges,
            label: 'Gündəlik kalori & makro izləmə',
          ),
          12.hs,
          const _FeatureItem(
            iconAsset: AppAssets.hydration,
            label: 'Su istehlakı monitorinqi',
          ),
          12.hs,
          const _FeatureItem(
            iconAsset: AppAssets.history,
            label: 'Oxuduğun məhsulların tarixi',
          ),
          28.hs,
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => context.go(AppRoutes.login),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A3A8F),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: 16.br),
              ),
              child: const Text(
                'Daxil ol',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String iconAsset;
  final String label;

  const _FeatureItem({required this.iconAsset, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: 8.br,
          ),
          child: Center(
            child: iconAsset.svg(width: 16, height: 16, color: Colors.white),
          ),
        ),
        12.ws,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
