import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/sized_box_extension.dart';

class OnboardTitle extends StatelessWidget {
  final String title;
  final String titleHighlight;
  final String emoji;

  const OnboardTitle({
    super.key,
    required this.title,
    required this.titleHighlight,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h2.copyWith(
            color: AppColors.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(
              titleHighlight,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.onboardLightGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            6.ws,
            Text(emoji, style: const TextStyle(fontSize: 28)),
          ],
        ),
      ],
    );
  }
}
