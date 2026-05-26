import 'package:flutter/material.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/asset_extension.dart';
import '../../../core/utils/radius_extension.dart';
import '../../../core/utils/sized_box_extension.dart';

class MenuItem extends StatelessWidget {
  final String svgAsset;
  final Color iconColor;
  final Color bgColor;
  final String label;
  final String? badge;
  final bool isLast;
  final VoidCallback? onTap;

  const MenuItem({
    super.key,
    required this.svgAsset,
    required this.label,
    this.iconColor = const Color(0xFF888888),
    this.bgColor = const Color(0xFFF5F5F5),
    this.badge,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.vertical(
            top: isLast ? Radius.zero : const Radius.circular(16),
            bottom: isLast ? const Radius.circular(16) : Radius.zero,
          ),
          onTap: onTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: 12.br,
                  ),
                  child: Center(
                    child: svgAsset.svg(
                      width: 16,
                      height: 16,
                      color: iconColor,
                    ),
                  ),
                ),
                12.ws,
                Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFBDBDBD),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFF3F3F3)),
      ],
    );
  }
}
