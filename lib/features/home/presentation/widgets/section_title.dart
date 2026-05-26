import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class SectionTitle extends StatelessWidget {
  final String icon;
  final String label;

  const SectionTitle({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon.svg(height: 16, width: 16),
        4.ws,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
