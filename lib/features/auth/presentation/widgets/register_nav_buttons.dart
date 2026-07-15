import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';

class RegisterNavButtons extends StatelessWidget {
  final bool showBack;
  final String nextLabel;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLoading;

  const RegisterNavButtons({
    super.key,
    required this.showBack,
    required this.nextLabel,
    required this.onNext,
    this.onBack,
    this.isLoading = false,
  });

  static const double _buttonHeight = 44;
  static const double _fontSize = 16;
  static const double _radius = 10;
  static const FontWeight _fontWeight = FontWeight.w500;

  @override
  Widget build(BuildContext context) {
    if (!showBack) {
      return SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          text: nextLabel,
          isLoading: isLoading,
          onPressed: onNext,
          height: _buttonHeight.h,
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          borderRadius: _radius,
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: _buttonHeight.h,
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: _radius.br),
                side: BorderSide(color: Colors.grey.shade300),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "Geri",
                style: AppTextStyles.h3.copyWith(
                  fontSize: _fontSize,
                  fontWeight: _fontWeight,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        8.ws,
        Expanded(
          flex: 2,
          child: CustomElevatedButton(
            text: nextLabel,
            isLoading: isLoading,
            onPressed: onNext,
            height: _buttonHeight.h,
            fontSize: _fontSize,
            fontWeight: _fontWeight,
            borderRadius: _radius,
          ),
        ),
      ],
    );
  }
}
