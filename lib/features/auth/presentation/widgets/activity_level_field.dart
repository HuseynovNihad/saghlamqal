import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class ActivityLevelField extends StatelessWidget {
  final String? value;
  final String? errorText;
  final ValueChanged<String?> onChanged;

  const ActivityLevelField({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final activityLevels = [
      {
        'value': 'sedentary',
        'label': context.l10n.activitySedentaryLabel,
        'subtext': context.l10n.activitySedentaryDescription,
        'icon': '🛋️',
      },
      {
        'value': 'light',
        'label': context.l10n.activityLightLabel,
        'subtext': context.l10n.activityLightDescription,
        'icon': '🚶',
      },
      {
        'value': 'moderate',
        'label': context.l10n.activityModerateLabel,
        'subtext': context.l10n.activityModerateDescription,
        'icon': '🏃',
      },
      {
        'value': 'active',
        'label': context.l10n.activityActiveLabel,
        'subtext': context.l10n.activityActiveDescription,
        'icon': '🏋️',
      },
      {
        'value': 'very_active',
        'label': context.l10n.activityVeryActiveLabel,
        'subtext': context.l10n.activityVeryActiveDescription,
        'icon': '🔥',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...activityLevels.map((level) {
          final isSelected = value == level['value'];

          return GestureDetector(
            onTap: () => onChanged(level['value']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: 8.pb,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                children: [
                  Text(level['icon']!, style: const TextStyle(fontSize: 24)),

                  12.ws,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level['label']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.headline,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),

                        2.hs,

                        Text(
                          level['subtext']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.bodyText,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  4.ws,

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.secondary
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      color: isSelected
                          ? AppColors.secondary
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),

        if (errorText != null) ...[
          4.hs,
          Text(errorText!, style: AppTextStyles.errorText),
        ],
      ],
    );
  }
}
