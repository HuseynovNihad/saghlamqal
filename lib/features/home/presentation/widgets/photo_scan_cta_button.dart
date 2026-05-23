import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class PhotoScanCtaButton extends StatelessWidget {
  const PhotoScanCtaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.photoScan),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.br,
          border: Border.all(color: AppColors.borderColor, width: 0.8),
        ),
        child: Row(
          children: [
            const _AnimatedCameraIcon(),
            12.ws,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Bu nə qədər kaloridir?',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  4.hs,
                  Text(
                    'Şəkil çək, dərhal cavab al',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCameraIcon extends StatefulWidget {
  const _AnimatedCameraIcon();

  @override
  State<_AnimatedCameraIcon> createState() => _AnimatedCameraIconState();
}

class _AnimatedCameraIconState extends State<_AnimatedCameraIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.07,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ScaleTransition(
          scale: _scaleAnim,
          child: Container(
            padding: 10.p,
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [AppColors.primary, AppColors.accent],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              color: AppColors.primary,
              borderRadius: 12.br,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        );
      },
    );
  }
}
