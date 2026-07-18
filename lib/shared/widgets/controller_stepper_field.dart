import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'ruler_picker_sheet.dart';

class ControllerStepperField extends StatelessWidget {
  const ControllerStepperField({
    super.key,
    required this.controller,
    required this.label,
    required this.unit,
    required this.min,
    required this.max,
    this.step = 1,
    this.majorEvery = 10,
    this.decimals = 0,
    this.allowManualInput = true,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String unit;
  final double min;
  final double max;
  final double step;
  final int majorEvery;
  final int decimals;
  final bool allowManualInput;
  final FormFieldValidator<String>? validator;

  Future<void> _openPicker(
    BuildContext context,
    FormFieldState<String> field,
  ) async {
    final current = double.tryParse(controller.text) ?? min;
    final result = await showRulerPickerSheet(
      context: context,
      title: label,
      min: min,
      max: max,
      step: step,
      majorEvery: majorEvery,
      unit: unit,
      decimals: decimals,
      initialValue: current.clamp(min, max),
      allowManualInput: allowManualInput,
    );
    if (result != null) {
      final text = result.toStringAsFixed(decimals);
      controller.text = text;
      field.didChange(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      builder: (field) {
        final hasValue = controller.text.isNotEmpty;
        final displayValue = hasValue ? controller.text : '-';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.bodyText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () => _openPicker(context, field),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textfieldColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: field.hasError
                        ? AppColors.error
                        : AppColors.borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            displayValue,
                            style: const TextStyle(
                              color: AppColors.headline,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (hasValue) ...[
                            const SizedBox(width: 3),
                            Text(
                              unit,
                              style: const TextStyle(
                                color: AppColors.bodyText,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.unfold_more_rounded,
                      size: 16,
                      color: AppColors.bodyText,
                    ),
                  ],
                ),
              ),
            ),
            if (field.hasError) ...[
              const SizedBox(height: 4),
              Text(
                field.errorText!,
                style: const TextStyle(color: AppColors.error, fontSize: 11),
              ),
            ],
          ],
        );
      },
    );
  }
}
