import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/recent_product_entity.dart';
import 'recent_product_macro.dart';

class RecentProductCard extends StatelessWidget {
  final RecentProductEntity product;

  const RecentProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          14.ws,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name ?? "Məhsul",
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.ws,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${product.calories} KKAL',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                8.hs,
                Row(
                  children: [
                    RecentProductMacro(
                      label: 'ZÜLAL',
                      value: '${product.protein}g',
                    ),
                    const SizedBox(width: 16),
                    RecentProductMacro(
                      label: 'KARBO',
                      value: '${product.carbs}g',
                    ),
                    const SizedBox(width: 16),
                    RecentProductMacro(label: 'YAĞ', value: '${product.fat}g'),
                  ],
                ),
                if (product.vitamins != null &&
                    product.vitamins!.isNotEmpty) ...[
                  8.hs,
                  Text(
                    'Vitaminlər',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  8.hs,
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
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${e.key}: ${value % 1 == 0 ? value.toInt() : value}',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
