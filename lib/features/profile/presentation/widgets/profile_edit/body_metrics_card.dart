import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/l10n/localization_extension.dart';
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
    this.progressMessage,
  });

  final int? height;
  final double? weight;
  final double? targetWeight;

  final ValueChanged<int> onHeightChanged;

  final ValueChanged<double> onWeightChanged;

  final ValueChanged<double> onTargetWeightChanged;

  final String? progressMessage;

  @override
  Widget build(BuildContext context) {
    final message = progressMessage ?? context.l10n.profileEditProgressMessage;

    return SectionCard(
      icon: Icons.straighten_rounded,
      title: context.l10n.profileEditPhysicalInfo,
      children: [
        Row(
          children: [
            Expanded(
              child: StepperField(
                label: context.l10n.profileEditHeight,
                value: height?.toDouble(),
                unit: context.l10n.profileEditUnitCm,
                min: 100,
                max: 220,
                step: 1,
                majorEvery: 10,
                decimals: 0,
                allowManualInput: false,
                onChanged: (value) {
                  onHeightChanged(value.round());
                },
              ),
            ),

            10.ws,

            Expanded(
              child: StepperField(
                label: context.l10n.profileEditCurrentWeight,
                value: weight,
                unit: context.l10n.profileEditUnitKg,
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
                label: context.l10n.profileEditTargetWeight,
                value: targetWeight,
                unit: context.l10n.profileEditUnitKg,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 16,
                color: AppColors.success,
              ),
            ),

            4.ws,

            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
