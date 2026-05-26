import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/padding_extension.dart';

class PhotoVitaminSection extends StatelessWidget {
  final Map<String, double?> vitamins;

  const PhotoVitaminSection({super.key, required this.vitamins});

  @override
  Widget build(BuildContext context) {
    final available = vitamins.entries.where((e) => e.value != null).toList();

    if (available.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: 16.p,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: 16.br,
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vitaminlər',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
          12.hs,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: available
                .map((e) => _VitaminChip(name: e.key, value: e.value!))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _VitaminChip extends StatelessWidget {
  final String name;
  final double value;

  const _VitaminChip({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 8.br,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Vit. $name  ',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '${value.toStringAsFixed(1)} mg',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.blue.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
