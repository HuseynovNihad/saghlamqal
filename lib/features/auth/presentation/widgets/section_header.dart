import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class SectionHeader extends StatelessWidget {
  final String icon;
  final String title;

  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        icon.svg(width: 16, height: 16, color: AppColors.primary),
        6.ws,
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        6.ws,
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}