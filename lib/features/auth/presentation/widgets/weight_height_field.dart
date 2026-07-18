import 'package:flutter/material.dart';
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
      children: [
        Expanded(
          child: ControllerStepperField(
            controller: weightController,
            label: "Çəki",
            unit: "kq",
            min: 20,
            max: 300,
            step: 0.1,
            majorEvery: 10,
            decimals: 1,
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
        12.ws,
        Expanded(
          child: ControllerStepperField(
            controller: heightController,
            label: "Boy",
            unit: "sm",
            min: 50,
            max: 250,
            step: 1,
            majorEvery: 10,
            decimals: 0,
            allowManualInput: false,
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
      ],
    );
  }
}
