import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class RecentProductsSection extends StatelessWidget {
  const RecentProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BLoC-dan gələcək
    final products = <Map<String, dynamic>>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("🕐", style: TextStyle(fontSize: 16)),
                6.hw,
                Text(
                  "Son oxudulanlar",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (products.isNotEmpty)
              Text(
                "Hamısı",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        12.hs,
        if (products.isEmpty)
          Container(
            width: double.infinity,
            padding: 28.py,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: 16.br,
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.qr_code_rounded,
                  size: 40,
                  color: Colors.grey.shade300,
                ),
                8.hs,
                Text(
                  "Hələ heç bir məhsul oxudulmayıb",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length.clamp(0, 5),
            separatorBuilder: (_, __) => 8.hs,
            itemBuilder: (context, index) =>
                _RecentProductCard(product: products[index]),
          ),
      ],
    );
  }
}

class _RecentProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const _RecentProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 12.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.fastfood_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.hs,
                Text(
                  "${product['calories'] ?? 0} kkal / 100q",
                  style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text("🔥", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
