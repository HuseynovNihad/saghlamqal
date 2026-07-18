import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/ruler_picker_sheet.dart';

class StepperField extends StatelessWidget {
  const StepperField({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
    this.step = 1,
    this.majorEvery = 10,
    this.decimals = 0,
    this.allowManualInput = true,
  });

  final String label;
  final double? value;
  final String unit;
  final double min;
  final double max;
  final double step;
  final int majorEvery;
  final int decimals;
  final bool allowManualInput;
  final ValueChanged<double> onChanged;

  Future<void> _openPicker(BuildContext context) async {
    final result = await showRulerPickerSheet(
      context: context,
      title: label,
      min: min,
      max: max,
      step: step,
      majorEvery: majorEvery,
      unit: unit,
      decimals: decimals,
      initialValue: value ?? min,
      allowManualInput: allowManualInput,
    );
    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final displayValue = hasValue ? value!.toStringAsFixed(decimals) : '-';

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
          onTap: () => _openPicker(context),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.textfieldColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderColor),
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
      ],
    );
  }
}
