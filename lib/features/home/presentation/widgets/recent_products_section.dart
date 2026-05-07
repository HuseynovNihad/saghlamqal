import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class RecentProductsSection extends StatelessWidget {
  const RecentProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BLoC-dan gələcək
    final products = <Map<String, dynamic>>[
      {
        'name': 'Activia Yogurt',
        'calories': 120,
        'protein': 5,
        'carbs': 10,
        'fat': 2,
        'imageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/320px-Good_Food_Display_-_NCI_Visuals_Online.jpg',
      },
      {
        'name': 'Protein Bar',
        'calories': 210,
        'protein': 20,
        'carbs': 15,
        'fat': 7,
        'imageUrl': null,
      },
      {
        'name': 'Narıncı Şirə',
        'calories': 85,
        'protein': 1,
        'carbs': 20,
        'fat': 0,
        'imageUrl': null,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Son oxudulanlar",
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (products.isNotEmpty)
              Text(
                "HAMISINA BAX",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.3,
                ),
              ),
          ],
        ),
        12.hs,
        if (products.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: 16.br,
              border: Border.all(
                color: AppColors.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // QR ikon + plus badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: 32,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                16.hs,
                Text(
                  "Hələ heç bir məhsul\noxudulmayıb",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                8.hs,

                Text(
                  "Məhsulları əlavə etmək üçün barkodu scan\nedin",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                20.hs,
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Scan funksiyasına yönləndir
                    },
                    icon: const Icon(
                      Icons.barcode_reader,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      "İndi scan et",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
            separatorBuilder: (_, __) => 10.hs,
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
    final String? imageUrl = product['imageUrl'] as String?;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          // Məhsul şəkli
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderIcon(),
                  )
                : _placeholderIcon(),
          ),

          const SizedBox(width: 12),

          // Ad + kalori + makrolar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ad
                Text(
                  product['name'] ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                6.hs,
                // Kalori badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${product['calories'] ?? 0} KKAL",
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
                    _MacroItem(
                      label: "ZÜLAL",
                      value: "${product['protein'] ?? 0}g",
                    ),
                    const SizedBox(width: 16),
                    _MacroItem(
                      label: "KARBO",
                      value: "${product['carbs'] ?? 0}g",
                    ),
                    const SizedBox(width: 16),
                    _MacroItem(label: "YAĞ", value: "${product['fat'] ?? 0}g"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey.shade400,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _placeholderIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.fastfood_rounded, color: AppColors.primary, size: 26),
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String label;
  final String value;

  const _MacroItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey.shade400,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
