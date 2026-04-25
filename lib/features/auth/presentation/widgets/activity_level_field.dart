import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
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

  static const List<Map<String, String>> _activityLevels = [
    {
      'value': 'sedentary',
      'label': 'Oturaq',
      'subtext': 'Demək olar ki, heç bir fiziki aktivlik yoxdur',
      'icon': '🛋️',
    },
    {
      'value': 'lightly_active',
      'label': 'Az aktiv',
      'subtext': 'Həftədə 1-3 gün yüngül idman',
      'icon': '🚶',
    },
    {
      'value': 'moderately_active',
      'label': 'Orta aktiv',
      'subtext': 'Həftədə 3-5 gün orta səviyyəli idman',
      'icon': '🏃',
    },
    {
      'value': 'very_active',
      'label': 'Çox aktiv',
      'subtext': 'Həftədə 6-7 gün intensiv idman',
      'icon': '🏋️',
    },
    {
      'value': 'extra_active',
      'label': 'Həddindən çox aktiv',
      'subtext': 'Gündə 2 dəfə idman və ya ağır fiziki iş',
      'icon': '🔥',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Aktivlik səviyyəsi", style: AppTextStyles.bodyMedium),
        8.hs,
        ...(_activityLevels.map((level) {
          final isSelected = value == level['value'];
          return GestureDetector(
            onTap: () => onChanged(level['value']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: 8.pb,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.headline.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.headline
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
                            color: isSelected
                                ? AppColors.headline
                                : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        2.hs,
                        Text(
                          level['subtext']!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isSelected
                                ? AppColors.headline.withOpacity(0.7)
                                : Colors.grey,
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
                            ? AppColors.headline
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      color: isSelected
                          ? AppColors.headline
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
        })),
        if (errorText != null) ...[
          4.hs,
          Text(errorText!, style: AppTextStyles.errorText),
        ],
      ],
    );
  }
}
