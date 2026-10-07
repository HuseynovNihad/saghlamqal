import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/localization_extension.dart';

class GoalOption {
  const GoalOption({
    required this.value,
    required this.icon,
    required this.color,
    this.label,
  });

  final String value;
  final String? label;
  final IconData icon;
  final Color color;
}

class GoalSelector extends StatelessWidget {
  const GoalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    this.options,
  });

  final String? selected;
  final ValueChanged<String> onChanged;
  final List<GoalOption>? options;

  List<GoalOption> _defaultOptions(BuildContext context) {
    return [
      GoalOption(
        value: 'lose_weight',
        label: context.l10n.profileGoalLoseWeight,
        icon: Icons.trending_down_rounded,
        color: AppColors.primary,
      ),
      GoalOption(
        value: 'maintain_weight',
        label: context.l10n.profileGoalMaintainWeight,
        icon: Icons.balance_rounded,
        color: AppColors.secondary,
      ),
      GoalOption(
        value: 'gain_weight',
        label: context.l10n.profileGoalGainWeight,
        icon: Icons.fitness_center_rounded,
        color: AppColors.secondary,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final resolvedOptions = options ?? _defaultOptions(context);

    return Row(
      children: resolvedOptions.map((goal) {
        final isSelected =
            selected != null &&
            selected!.toLowerCase() == goal.value.toLowerCase();

        final isLast = goal.value == resolvedOptions.last.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 8),
            child: GestureDetector(
              onTap: () => onChanged(goal.value),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.borderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(goal.icon, color: goal.color, size: 26),
                    const SizedBox(height: 8),
                    Text(
                      goal.label ?? goal.value,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.headline,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
