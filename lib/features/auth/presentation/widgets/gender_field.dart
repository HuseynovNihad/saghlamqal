import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class GenderField extends StatelessWidget {
  final String? value;
  final String? errorText;
  final ValueChanged<String?> onChanged;

  const GenderField({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  static const List<Map<String, String>> _genders = [
    {'value': 'male', 'label': 'Kişi', 'icon': '👨'},
    {'value': 'female', 'label': 'Qadın', 'icon': '👩'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cins", style: AppTextStyles.bodyMedium),
        4.hs,
        Row(
          children: _genders.map((g) {
            final isSelected = value == g['value'];
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(g['value']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: 8.pr,
                  padding: 14.py,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : AppColors.borderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: 16.br,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(g['icon']!, style: const TextStyle(fontSize: 20)),
                      8.hw,
                      Text(
                        g['label']!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (errorText != null) ...[
          4.hs,
          Text(
            errorText!,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.red),
          ),
        ],
      ],
    );
  }
}
