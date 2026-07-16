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
    required this.onHeightDecrement,
    required this.onHeightIncrement,
    required this.onWeightDecrement,
    required this.onWeightIncrement,
    required this.onTargetWeightDecrement,
    required this.onTargetWeightIncrement,
    this.progressMessage = "Əla gedir! Doğru yoldasan.",
  });

  final int? height;
  final double? weight;
  final double? targetWeight;
  final VoidCallback onHeightDecrement;
  final VoidCallback onHeightIncrement;
  final VoidCallback onWeightDecrement;
  final VoidCallback onWeightIncrement;
  final VoidCallback onTargetWeightDecrement;
  final VoidCallback onTargetWeightIncrement;
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
                value: height?.toString() ?? '',
                unit: 'sm',
                onDecrement: onHeightDecrement,
                onIncrement: onHeightIncrement,
              ),
            ),
            10.ws,
            Expanded(
              child: StepperField(
                label: 'Cari çəki',
                value: weight?.toStringAsFixed(0) ?? '',
                unit: 'kq',
                onDecrement: onWeightDecrement,
                onIncrement: onWeightIncrement,
              ),
            ),
            10.ws,
            Expanded(
              child: StepperField(
                label: 'Hədəf çəki',
                value: targetWeight?.toStringAsFixed(0) ?? '',
                unit: 'kq',
                showCheck: true,
                onDecrement: onTargetWeightDecrement,
                onIncrement: onTargetWeightIncrement,
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
