import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/localization_extension.dart';

class GenderSegmentedControl extends StatelessWidget {
  const GenderSegmentedControl({
    super.key,
    required this.selected,
    required this.onChanged,
    this.options = const ['male', 'female'],
  });

  final String? selected;
  final ValueChanged<String> onChanged;
  final List<String> options;

  String _label(BuildContext context, String value) {
    return switch (value.toLowerCase()) {
      'male' => context.l10n.profileGenderMale,
      'female' => context.l10n.profileGenderFemale,
      _ => value,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected =
              selected != null &&
              selected!.toLowerCase() == option.toLowerCase();

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: Text(
                  _label(context, option),
                  style: TextStyle(
                    color: AppColors.headline,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
