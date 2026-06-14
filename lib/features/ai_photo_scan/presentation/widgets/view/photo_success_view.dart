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

  const PhotoSuccessView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final hasServing =
        product.servingSize != null && product.servingUnit != null;

    return Column(
      children: [
        Text(
          product.name,
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (hasServing) ...[
          6.hs,
          Text(
            '${product.servingSize} ${product.servingUnit} üzrə',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        20.hs,
        Container(
          width: double.infinity,
          padding: 16.p,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: 16.br,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PhotoNutrientItem(
                label: 'Kalori',
                value: product.calories?.toStringAsFixed(0) ?? '-',
                unit: 'kkal',
                color: AppColors.primary,
              ),
              _Divider(),
              PhotoNutrientItem(
                label: 'Zülal',
                value: product.protein?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.blue,
              ),
              _Divider(),
              PhotoNutrientItem(
                label: 'Karbohidrat',
                value: product.carbs?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.orange,
              ),
              _Divider(),
              PhotoNutrientItem(
                label: 'Yağ',
                value: product.fat?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.red,
              ),
            ],
          ),
        ),
        if (product.vitamins != null && product.vitamins!.isNotEmpty) ...[
          16.hs,
          PhotoVitaminSection(vitamins: product.vitamins!),
        ],
        16.hs,
        Container(
          width: double.infinity,
          padding: 16.p,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: 16.br,
          ),
          child: Text(
            product.advice,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.green.shade800,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 50, color: Colors.grey.shade200);
}
