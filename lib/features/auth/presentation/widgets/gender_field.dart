import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/l10n/localization_extension.dart';
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

  @override
  Widget build(BuildContext context) {
    final genders = [
      {'value': 'male', 'label': context.l10n.profileGenderMale, 'icon': '👨'},
      {
        'value': 'female',
        'label': context.l10n.profileGenderFemale,
        'icon': '👩',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.profileGenderLabel, style: AppTextStyles.bodyMedium),

        4.hs,

        Row(
          children: genders.map((gender) {
            final isSelected = value == gender['value'];

            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(gender['value']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: 8.pr,
                  padding: 14.py,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary.withOpacity(0.1)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.secondary
                          : AppColors.borderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: 16.br,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        gender['icon']!,
                        style: const TextStyle(fontSize: 20),
                      ),

                      8.ws,

                      Text(
                        gender['label']!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? AppColors.headline
                              : AppColors.bodyText,
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
