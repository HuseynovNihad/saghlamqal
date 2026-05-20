import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
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
          Expanded(child: _buildInfo()),
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
      child: const Center(child: Text('🍎', style: TextStyle(fontSize: 22))),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.headline,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (item.brand != null) ...[
          2.verticalSpace,
          Text(item.brand!, style: AppTextStyles.bodySmall),
        ],
        6.verticalSpace,
        _buildMacros(),
      ],
    );
  }

  Widget _buildMacros() {
    return Row(
      children: [
        _MacroPill(
          label: '${item.calories.toInt()} kkal',
          color: AppColors.primary,
        ),
        4.horizontalSpace,
        _MacroPill(label: '${item.protein.toInt()}q Z', color: AppColors.info),
        4.horizontalSpace,
        _MacroPill(label: '${item.carbs.toInt()}q K', color: AppColors.warning),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onRemove();

            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item.name} favoritlərdən silindi'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.headline,
                duration: const Duration(seconds: 2),

                action: SnackBarAction(
                  label: 'Geri qaytar',
                  textColor: Colors.white,
                  onPressed: onAdd,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.favorite_rounded,
            color: AppColors.error,
            size: 24,
          ),
        ),
      ],
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
        color: color.withOpacity(0.12),
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
