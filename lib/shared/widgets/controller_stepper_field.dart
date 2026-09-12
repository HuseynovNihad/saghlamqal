import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'ruler_picker_sheet.dart';

class ControllerStepperField extends StatefulWidget {
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

  /// Köhnə API ilə uyğunluğu qorumaq üçün saxlanılıb.
  /// Yeni picker dizaynında artıq istifadə olunmur.
  final int majorEvery;

  final int decimals;
  final bool allowManualInput;

  final FormFieldValidator<String>? validator;

  @override
  State<ControllerStepperField> createState() => _ControllerStepperFieldState();
}

class _ControllerStepperFieldState extends State<ControllerStepperField> {
  bool _isPickerOpen = false;

  Future<void> _openPicker(
    BuildContext context,
    FormFieldState<String> field,
  ) async {
    if (_isPickerOpen) return;

    _isPickerOpen = true;

    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final rawText = widget.controller.text.trim().replaceAll(',', '.');

      final parsedValue = double.tryParse(rawText);

      final currentValue = (parsedValue ?? widget.min)
          .clamp(widget.min, widget.max)
          .toDouble();

      final result = await showRulerPickerSheet(
        context: context,
        title: widget.label,
        min: widget.min,
        max: widget.max,
        initialValue: currentValue,
        step: widget.step,
        majorEvery: widget.majorEvery,
        unit: widget.unit,
        decimals: widget.decimals,
        allowManualInput: widget.allowManualInput,
      );

      if (!mounted || result == null) {
        return;
      }

      final formattedValue = result.toStringAsFixed(widget.decimals);

      if (widget.controller.text == formattedValue) {
        return;
      }

      widget.controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );

      field.didChange(formattedValue);
    } finally {
      _isPickerOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller.text,
      validator: widget.validator,
      builder: (field) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.controller,
          builder: (context, controllerValue, child) {
            final text = controllerValue.text.trim();

            final hasValue = text.isNotEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.bodyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      _openPicker(context, field);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      constraints: const BoxConstraints(minHeight: 46),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
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
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Flexible(
                                  child: Text(
                                    hasValue ? text : '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.headline,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                if (hasValue && widget.unit.isNotEmpty) ...[
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.unit,
                                    style: const TextStyle(
                                      color: AppColors.bodyText,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(
                            Icons.tune_rounded,
                            size: 18,
                            color: AppColors.bodyText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (field.hasError) ...[
                  const SizedBox(height: 4),
                  Text(
                    field.errorText ?? '',
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}
