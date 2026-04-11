import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  // ================= HEADLINES (Poppins) =================

  static TextStyle h1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.poppins,
    color: AppColors.headline,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.poppins,
    color: AppColors.headline,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.poppins,
    color: AppColors.headline,
  );

  // ================= BODY (Inter) =================

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.inter,
    color: AppColors.bodyText,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.inter,
    color: AppColors.bodyText,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.inter,
    color: AppColors.bodyText,
  );

  // ================= BUTTON =================

  static TextStyle buttonText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.inter,
    color: Colors.white,
  );

  // ================= CAPTION =================

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.inter,
    color: const Color(0xFF889A90),
  );

  // ================= CALORIE VALUE =================

  static TextStyle kCalValue = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.poppins,
    color: AppColors.primary,
  );

  // ================= FİELD LABEL =================

  static TextStyle fieldLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.poppins,
    color: AppColors.headline,
  );

  // ================= FİELD HİNT TEXT STYLE =================

  static TextStyle fieldHintText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.poppins,
    color: Colors.grey,
  );

  // ================= ERROR TEXT STYLE =================

  static TextStyle errorText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.poppins,
    color: AppColors.error,
  );
}
