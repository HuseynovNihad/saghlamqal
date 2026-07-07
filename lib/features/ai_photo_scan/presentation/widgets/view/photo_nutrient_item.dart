import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_colors.dart';
import 'package:kalori_tracker/core/utils/padding_extension.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoNutrientItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String label;
  final String value;
  final String unit;
  final bool unitBelow;

  const PhotoNutrientItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
    this.unitBelow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 12.py + 4.px,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        border: Border.all(color: Color(0xFFF7F7F7), width: 0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          8.hs,
          unitBelow
              ? Text(
                  value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontSize: 18,
                    color: AppColors.primary,
                    height: 1.0,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' $unit',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

          if (unitBelow) 4.hs,

          SizedBox(
            height: 16,
            child: unitBelow
                ? Text(
                    unit,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      height: 1.0,
                    ),
                  )
                : null,
          ),

          2.hs,
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
