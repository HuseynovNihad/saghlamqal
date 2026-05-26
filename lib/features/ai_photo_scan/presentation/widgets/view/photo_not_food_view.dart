import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoNotFoodView extends StatelessWidget {
  const PhotoNotFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.no_food_rounded,
            color: Colors.orange,
            size: 32,
          ),
        ),
        16.hs,
        Text(
          'Qida aşkarlanmadı',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        8.hs,
        Text(
          'Zəhmət olmasa yeyəcək və ya içəcək şəklini çəkin.',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
