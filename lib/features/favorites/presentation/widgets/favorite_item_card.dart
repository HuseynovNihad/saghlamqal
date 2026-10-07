import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../domain/entities/favorite_item_entity.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoriteItemEntity item;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const FavoriteItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Row(
        children: [
          _buildEmoji(),

          8.horizontalSpace,

          Expanded(child: _buildInfo(context)),

          8.horizontalSpace,

          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildEmoji() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: 12.br,
      ),
      child: Center(
        child: Text(
          item.icon != null && item.icon!.isNotEmpty ? item.icon! : '🍎',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final productName = item.name?.trim().isNotEmpty == true
        ? item.name!.trim()
        : context.l10n.commonProduct;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.headline,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        6.verticalSpace,

        _buildMacros(context),
      ],
    );
  }

  Widget _buildMacros(BuildContext context) {
    final calories = item.calories?.toInt() ?? 0;
    final protein = item.protein?.toInt() ?? 0;
    final carbs = item.carbs?.toInt() ?? 0;

    return Row(
      children: [
        _MacroPill(
          label: context.l10n.favoritesCaloriesValue(calories),
          color: AppColors.primary,
        ),

        4.horizontalSpace,

        _MacroPill(
          label: context.l10n.favoritesProteinValue(protein),
          color: AppColors.info,
        ),

        4.horizontalSpace,

        _MacroPill(
          label: context.l10n.favoritesCarbsValue(carbs),
          color: AppColors.warning,
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final productName = item.name?.trim().isNotEmpty == true
            ? item.name!.trim()
            : context.l10n.commonProduct;

        onRemove();

        CustomSnackBar.show(
          context,
          message: context.l10n.homeProductRemovedFavorite(productName),
          type: SnackBarType.info,
          position: SnackBarPosition.top,
        );
      },
      child: AppAssets.favoriteFill.svg(height: 20, width: 20),
    );
  }
}

class _MacroPill extends StatelessWidget {
  final String label;
  final Color color;

  const _MacroPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
