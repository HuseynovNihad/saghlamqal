import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/recent_product_entity.dart';
import 'recent_product_macro.dart';

class RecentProductCard extends StatelessWidget {
  final RecentProductEntity product;

  const RecentProductCard({super.key, required this.product});

  String _formatDate(DateTime date) {
  final localDate = date.toLocal(); 
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateOnly = DateTime(localDate.year, localDate.month, localDate.day);
  final timeStr =
      '${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}';

  if (dateOnly == today) return 'Bugün, $timeStr';

  final yesterday = today.subtract(const Duration(days: 1));
  if (dateOnly == yesterday) return 'Dünən, $timeStr';

  return '${localDate.day.toString().padLeft(2, '0')}.${localDate.month.toString().padLeft(2, '0')}.${localDate.year}, $timeStr';
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    product.icon ?? '🍽️',
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
              ),
              12.ws,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? 'Məhsul',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.hs,
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          RecentProductMacro(
                            label: 'ZÜLAL',
                            value: '${product.protein}g',
                            color: const Color(0xFFE05C3A),
                          ),
                          8.ws,
                          VerticalDivider(
                            color: AppColors.borderColor,
                            thickness: 0.8,
                            width: 1,
                          ),
                          8.ws,
                          RecentProductMacro(
                            label: 'KARBO',
                            value: '${product.carbs}g',
                            color: const Color(0xFF2F7BE8),
                          ),
                          8.ws,
                          VerticalDivider(
                            color: AppColors.borderColor,
                            thickness: 0.8,
                            width: 1,
                          ),
                          8.ws,
                          RecentProductMacro(
                            label: 'YAĞ',
                            value: '${product.fat}g',
                            color: const Color(0xFFF5A623),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              8.ws,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7EE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${product.calories} KKAL',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: const Color(0xFF34A853),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          if (product.vitamins != null &&
              product.vitamins!.entries.any((e) => e.value != null)) ...[
            12.hs,
            Divider(color: AppColors.borderColor, thickness: 0.5, height: 0.7),
            12.hs,
            Text(
              'Vitaminlər',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF77787F),
              ),
            ),
            6.hs,
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: product.vitamins!.entries
                  .where((e) => e.value != null)
                  .map((e) {
                    final value = e.value!;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${e.key}: ${value % 1 == 0 ? value.toInt() : value}',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    );
                  })
                  .toList(),
            ),
          ],
          12.hs,
          Divider(color: AppColors.borderColor, thickness: 0.5, height: 0.7),
          12.hs,
          Row(
            children: [
              AppAssets.calendar.svg(height: 14, width: 14, color: Colors.grey),
              6.ws,
              Text(
                _formatDate(product.createdAt),
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
