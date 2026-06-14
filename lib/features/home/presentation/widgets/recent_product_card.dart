import 'package:cached_network_image/cached_network_image.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: 12.br,
            child: product.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: product.imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _placeholder(),
                    errorWidget: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          14.ws,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.hs,
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
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: product.vitamins!.entries.map((e) {
                      final value = e.value;
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
                          value != null
                              ? '${e.key}: ${value % 1 == 0 ? value.toInt() : value}'
                              : e.key,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: 12.br,
      ),
      child: Icon(Icons.fastfood_rounded, color: AppColors.primary, size: 26),
    );
  }
}
