import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class PhotoCaptureButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const PhotoCaptureButton({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SideButton(
              icon: Icons.photo_library_outlined,
              label: 'Qalereya',
              onTap: () {},
            ),
            GestureDetector(
              onTap: isLoading ? null : onTap,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLoading ? Colors.white38 : Colors.white,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                child: isLoading
                    ? Padding(
                        padding: 18.p,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black54,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 32,
                        color: Colors.black87,
                      ),
              ),
            ),
            _SideButton(
              icon: Icons.help_outline_rounded,
              label: 'Necə skan etməli?',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SideButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: 16.br,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: 78,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: 16.br,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                4.hs,
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
