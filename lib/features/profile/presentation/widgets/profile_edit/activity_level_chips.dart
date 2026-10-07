import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/localization_extension.dart';

class ActivityLevelChips extends StatelessWidget {
  const ActivityLevelChips({
    super.key,
    required this.selected,
    required this.onChanged,
    this.options = const [
      'sedentary',
      'light',
      'moderate',
      'active',
      'very_active',
    ],
  });

  final String? selected;
  final ValueChanged<String> onChanged;
  final List<String> options;

  String _label(BuildContext context, String value) {
    return switch (value.toLowerCase()) {
      'sedentary' => context.l10n.profileActivitySedentary,
      'light' => context.l10n.profileActivityLight,
      'moderate' => context.l10n.profileActivityModerate,
      'active' => context.l10n.profileActivityActive,
      'very_active' => context.l10n.profileActivityVeryActive,
      _ => value,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final option = options[index];

          final isSelected =
              selected != null &&
              selected!.toLowerCase() == option.toLowerCase();

          return GestureDetector(
            onTap: () => onChanged(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textfieldColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.borderColor,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _label(context, option),
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.headline,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
