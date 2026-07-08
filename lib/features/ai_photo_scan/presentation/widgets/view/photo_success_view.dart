import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/photo_product_entity.dart';
import 'photo_nutrient_item.dart';
import 'photo_vitamin_section.dart';

class PhotoSuccessView extends StatelessWidget {
  final PhotoProductEntity product;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const PhotoSuccessView({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final hasServing =
        product.servingSize != null && product.servingUnit != null;
    final adviceItems = product.advice
        .where((e) => e.trim().isNotEmpty)
        .toList();
    final hasVitamins =
        product.vitamins != null &&
        product.vitamins!.values.any((v) => v != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (product.icon != null) ...[
              Text(product.icon!, style: const TextStyle(fontSize: 44)),
              12.ws,
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (hasServing) ...[
                    4.hs,
                    Text(
                      '${product.servingSize} ${product.servingUnit}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ],
              ),
            ),
            if (onFavoriteToggle != null) ...[
              8.ws,
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 22,
                    color: isFavorite ? Colors.red : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ],
        ),
        24.hs,
        Container(
          width: double.infinity,
          padding: 8.px + 16.py,
          decoration: BoxDecoration(
            color: Color(0xFFFEFEFE),
            borderRadius: 16.br,
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${product.servingSize ?? 100} ${product.servingUnit ?? 'g'} üzrə qida dəyərləri',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              14.hs,
              Row(
                children: [
                  Expanded(
                    child: PhotoNutrientItem(
                      icon: Icons.local_fire_department_rounded,
                      iconBgColor: Colors.green.shade50,
                      iconColor: Colors.green,
                      label: 'Kalori',
                      value: product.calories?.toStringAsFixed(0) ?? '-',
                      unit: 'kkal',
                      unitBelow: true,
                    ),
                  ),
                  8.ws,
                  Expanded(
                    child: PhotoNutrientItem(
                      icon: Icons.fitness_center_rounded,
                      iconBgColor: Colors.blue.shade50,
                      iconColor: Colors.blue,
                      label: 'Zülal',
                      value: product.protein?.toStringAsFixed(1) ?? '-',
                      unit: 'g',
                    ),
                  ),
                  8.ws,
                  Expanded(
                    child: PhotoNutrientItem(
                      icon: Icons.grain_rounded,
                      iconBgColor: Colors.orange.shade50,
                      iconColor: Colors.orange,
                      label: 'Karbohidrat',
                      value: product.carbs?.toStringAsFixed(1) ?? '-',
                      unit: 'g',
                    ),
                  ),
                  8.ws,
                  Expanded(
                    child: PhotoNutrientItem(
                      icon: Icons.water_drop_rounded,
                      iconBgColor: Colors.red.shade50,
                      iconColor: Colors.red,
                      label: 'Yağ',
                      value: product.fat?.toStringAsFixed(1) ?? '-',
                      unit: 'g',
                    ),
                  ),
                ],
              ),

              if (hasVitamins) ...[
                20.hs,
                Text(
                  'Vitaminlər',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                14.hs,
                PhotoVitaminSection(vitamins: product.vitamins!),
              ],
            ],
          ),
        ),

        // ---- Tövsiyə bloku (leaf ikonu + bullet list) ----
        if (adviceItems.isNotEmpty) ...[
          16.hs,
          Container(
            width: double.infinity,
            padding: 16.p,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: 16.br,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.eco_rounded,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                ),
                12.ws,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: adviceItems
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade800,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                8.ws,
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.green.shade900,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
