import 'package:flutter/material.dart';

import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/controller_stepper_field.dart';

class WeightHeightField extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;

  const WeightHeightField({
    super.key,
    required this.weightController,
    required this.heightController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ControllerStepperField(
            controller: weightController,
            label: context.l10n.profileWeightLabel,
            unit: context.l10n.unitKg,
            min: 20,
            max: 300,
            step: 0.1,
            majorEvery: 10,
            decimals: 1,
            allowManualInput: true,
            validator: (value) {
              return AppValidators.combine(value, [
                (value) => AppValidators.isNotEmpty(
                  value,
                  message: context.l10n.validationRequired,
                ),
              ]);
            },
          ),
        ),

        12.ws,

        Expanded(
          child: ControllerStepperField(
            controller: heightController,
            label: context.l10n.profileHeightLabel,
            unit: context.l10n.unitCm,
            min: 50,
            max: 250,
            step: 1,
            majorEvery: 10,
            decimals: 0,
            allowManualInput: false,
            validator: (value) {
              return AppValidators.combine(value, [
                (value) => AppValidators.isNotEmpty(
                  value,
                  message: context.l10n.validationRequired,
                ),
              ]);
            },
          ),
        ),
      ],
    );
  }
}
