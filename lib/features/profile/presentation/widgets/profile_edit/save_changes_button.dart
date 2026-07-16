import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';
import 'package:kalori_tracker/core/utils/sized_box_extension.dart';

import '../../../../../core/constants/app_colors.dart';

class SaveChangesButton extends StatelessWidget {
  const SaveChangesButton({
    super.key,
    required this.onPressed,
    this.label = 'Yadda saxla',
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline_rounded, size: 20),
            6.ws,
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
