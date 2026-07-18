import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import 'section_card.dart';
import 'stepper_field.dart';

class BodyMetricsCard extends StatelessWidget {
  const BodyMetricsCard({
    super.key,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onTargetWeightChanged,
    this.progressMessage = "Əla gedir! Doğru yoldasan.",
  });

  final int? height;
  final double? weight;
  final double? targetWeight;
  final ValueChanged<int> onHeightChanged;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<double> onTargetWeightChanged;
  final String progressMessage;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.straighten_rounded,
      title: 'Fiziki məlumatlar',
      children: [
        Row(
          children: [
            Expanded(
              child: StepperField(
                label: 'Boy',
                value: height?.toDouble(),
                unit: 'sm',
                min: 100,
                max: 220,
                step: 1,
                majorEvery: 10,
                decimals: 0,
                allowManualInput: false,
                onChanged: (v) => onHeightChanged(v.round()),
              ),
            ),
            10.ws,
            Expanded(
              child: StepperField(
                label: 'Cari çəki',
                value: weight,
                unit: 'kq',
                min: 30,
                max: 200,
                step: 0.1,
                majorEvery: 10,
                decimals: 1,
                onChanged: onWeightChanged,
              ),
            ),
            10.ws,
            Expanded(
              child: StepperField(
                label: 'Hədəf çəki',
                value: targetWeight,
                unit: 'kq',
                min: 30,
                max: 200,
                step: 0.1,
                majorEvery: 10,
                decimals: 1,
                onChanged: onTargetWeightChanged,
              ),
            ),
          ],
        ),
        12.hs,
        Row(
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              size: 16,
              color: AppColors.success,
            ),
            4.ws,
            Text(
              progressMessage,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
