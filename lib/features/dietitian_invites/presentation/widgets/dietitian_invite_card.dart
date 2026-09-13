import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/dietitian_invite_entity.dart';
import '../bloc/dietitian_invites_bloc.dart';
import 'dietitian_avatar.dart';

class DietitianInviteCard extends StatelessWidget {
  final DietitianInviteEntity invite;
  final bool isLoading;

  const DietitianInviteCard({
    super.key,
    required this.invite,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final dietitian = invite.dietitian;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DietitianAvatar(
                imageUrl: dietitian.profilePhoto,
                name: dietitian.fullName,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dietitian.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.h3.copyWith(fontSize: 16.sp),
                    ),
                    if (dietitian.title.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        dietitian.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.bodyText,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Text(
            'Sizi pasiyenti olmağa dəvət edib.',
            style: AppTextStyles.bodyMedium,
          ),

          if (_hasLocationInfo(dietitian)) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18.sp,
                  color: AppColors.bodyText,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    _locationText(dietitian),
                    style: AppTextStyles.bodySmall,
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 18.h),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46.h,
                  child: OutlinedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<DietitianInvitesBloc>().add(
                              DietitianInviteRejected(invite.id),
                            );
                          },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Rədd et',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: SizedBox(
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<DietitianInvitesBloc>().add(
                              DietitianInviteAccepted(invite.id),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('Qəbul et', style: AppTextStyles.buttonText),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _hasLocationInfo(DietitianInfoEntity dietitian) {
    return (dietitian.clinicName?.trim().isNotEmpty ?? false) ||
        (dietitian.city?.trim().isNotEmpty ?? false);
  }

  String _locationText(DietitianInfoEntity dietitian) {
    final values = <String>[];

    if (dietitian.clinicName?.trim().isNotEmpty ?? false) {
      values.add(dietitian.clinicName!.trim());
    }

    if (dietitian.city?.trim().isNotEmpty ?? false) {
      values.add(dietitian.city!.trim());
    }

    return values.join(' • ');
  }
}
