import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoLoadingView extends StatelessWidget {
  const PhotoLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(color: AppColors.primary),
        16.hs,
        Text(
          'Təhlil edilir...',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
