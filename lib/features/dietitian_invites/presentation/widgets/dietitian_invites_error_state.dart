import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DietitianInvitesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const DietitianInvitesErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68.w,
              height: 68.w,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 32.sp,
                color: AppColors.error,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Dəvətləri yükləmək mümkün olmadı',
              textAlign: TextAlign.center,
              style: AppTextStyles.h3,
            ),

            SizedBox(height: 8.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.errorText,
            ),

            SizedBox(height: 18.h),

            SizedBox(
              height: 46.h,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('Yenidən yoxla', style: AppTextStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
