import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class GoalField extends StatelessWidget {
  final String? value;
  final String? errorText;
  final ValueChanged<String?> onChanged;

  const GoalField({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  static const List<Map<String, String>> _goals = [
    {
      'value': 'lose_weight',
      'label': 'Çəki itirmək',
      'subtext': 'Kalori defisiti ilə arıqlamaq istəyirəm',
      'icon': '📉',
    },
    {
      'value': 'maintain_weight',
      'label': 'Çəkini saxlamaq',
      'subtext': 'Hazırkı çəkimi qorumaq istəyirəm',
      'icon': '⚖️',
    },
    {
      'value': 'gain_weight',
      'label': 'Çəki artırmaq',
      'subtext': 'Kalori profisiti ilə çəki qazanmaq istəyirəm',
      'icon': '📈',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...(_goals.map((goal) {
          final isSelected = value == goal['value'];
          return GestureDetector(
            onTap: () => onChanged(goal['value']),
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
                  Text(goal['icon']!, style: const TextStyle(fontSize: 24)),
                  12.ws,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal['label']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.headline,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                        2.hs,
                        Text(
                          goal['subtext']!,
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
        })),
        if (errorText != null) ...[
          4.hs,
          Text(errorText!, style: AppTextStyles.errorText),
        ],
      ],
    );
  }
}
