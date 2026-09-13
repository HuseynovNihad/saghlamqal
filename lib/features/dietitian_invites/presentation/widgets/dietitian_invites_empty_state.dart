import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../bloc/dietitian_invites_bloc.dart';

class DietitianInvitesEmptyState extends StatelessWidget {
  const DietitianInvitesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        context.read<DietitianInvitesBloc>().add(
          const DietitianInvitesRequested(),
        );
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        children: [
          SizedBox(height: 150.h),

          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_outlined,
              size: 34.sp,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            'Hazırda yeni dəvətiniz yoxdur',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3,
          ),

          SizedBox(height: 8.h),

          Text(
            'Dietoloq sizə dəvət göndərdikdə burada görünəcək.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.bodyText),
          ),
        ],
      ),
    );
  }
}
