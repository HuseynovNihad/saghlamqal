import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

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

  static const Map<String, String> _labels = {
    'male': 'Kişi',
    'female': 'Qadın',
  };

  String _label(String value) => _labels[value.toLowerCase()] ?? value;

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
                      ? AppColors.primary.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: Text(
                  _label(option),
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
