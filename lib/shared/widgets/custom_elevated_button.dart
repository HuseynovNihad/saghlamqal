import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/radius_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final double? borderRadius;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.textStyle,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ?? AppTextStyles.h3;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(borderRadius: (borderRadius ?? 12).br),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                width: (height ?? 50.h) * 0.44,
                height: (height ?? 50.h) * 0.44,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: baseStyle.copyWith(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: foregroundColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}
