import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoNutrientItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const PhotoNutrientItem({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTextStyles.h3.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.ws,
            Text(unit, style: AppTextStyles.bodySmall.copyWith(color: color)),
          ],
        ),
        4.hs,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
