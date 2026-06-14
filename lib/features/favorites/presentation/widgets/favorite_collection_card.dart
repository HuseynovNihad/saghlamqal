import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../domain/entities/favorite_collection_entity.dart';

class FavoriteCollectionCard extends StatelessWidget {
  final FavoriteCollectionEntity collection;
  final VoidCallback onDelete;

  const FavoriteCollectionCard({
    super.key,
    required this.collection,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = (screenWidth - 56.w) / 3;

    return Container(
      width: cardWidth,
      constraints: BoxConstraints(minHeight: 110.h),
      padding: 10.p,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: 14.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: 10.br,
            ),
            child: Center(
              child: collection.icon?.svg(width: 20, height: 20),
            ),
          ),

          4.verticalSpace,

          Flexible(
            child: Text(
              collection.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.headline,
                height: 1.2,
              ),
            ),
          ),

          4.verticalSpace,

          Text(
            '${collection.itemCount} məhsul',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
