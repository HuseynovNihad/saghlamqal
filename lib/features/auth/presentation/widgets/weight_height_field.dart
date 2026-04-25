import 'package:flutter/material.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_text_field.dart';

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
          child: CustomTextField(
            label: "Çəki (kq)",
            hintText: "00.0",
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
        12.ws,
        Expanded(
          child: CustomTextField(
            label: "Boy (sm)",
            hintText: "000",
            controller: heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
      ],
    );
  }
}
