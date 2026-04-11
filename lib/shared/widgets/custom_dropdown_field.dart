import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/sized_box_extension.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String? label;
  final bool required;
  final String? errorText;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final double borderRadius;
  final Color? fillColor;
  final Widget? prefixIcon;

  const CustomDropdownField({
    super.key,
    this.label,
    this.required = false,
    this.errorText,
    this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.borderRadius = 16,
    this.fillColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: AppTextStyles.bodyMedium),
              if (required)
                Text(" *", style: TextStyle(color: AppColors.error)),
            ],
          ),
        if (label != null) 8.hs,

        Container(
          height: 48,
          decoration: BoxDecoration(
            color: fillColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: hasError ? AppColors.error : AppColors.borderColor,
              width: hasError ? 1.5 : 1,
            ),
          ),
          padding: 16.px,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: hintText != null
                  ? Text(hintText!, style: AppTextStyles.fieldHintText)
                  : null,
              items: items,
              onChanged: onChanged,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black54,
              ),
            ),
          ),
        ),

        if (hasError) ...[
          6.hs,
          Text(errorText!, style: AppTextStyles.errorText),
        ],
      ],
    );
  }
}
