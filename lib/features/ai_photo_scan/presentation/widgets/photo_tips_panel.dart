import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../core/utils/padding_extension.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class PhotoTipsPanel extends StatelessWidget {
  final double width;
  const PhotoTipsPanel({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: 16.br,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: 16.br,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TipItem(
                    icon: Icons.wb_sunny_outlined,
                    label: 'Yaxşı işıq',
                  ),
                ),
                _Divider(),
                Expanded(
                  child: _TipItem(
                    icon: Icons.crop_outlined,
                    label: 'Çərçivəyə sığdırın',
                  ),
                ),
                _Divider(),
                Expanded(
                  child: _TipItem(
                    icon: Icons.stay_current_portrait_outlined,
                    label: 'Sabit saxlayın',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TipItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        6.hs,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white70,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 4.px,
      child: Container(width: 1, height: 48, color: Colors.white24),
    );
  }
}
