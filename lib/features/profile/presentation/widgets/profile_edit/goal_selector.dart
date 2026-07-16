import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class GoalOption {
  const GoalOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
}

class GoalSelector extends StatelessWidget {
  GoalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    List<GoalOption>? options,
  }) : options =
           options ??
           [
             GoalOption(
               value: 'lose_weight',
               label: 'Arıqlamaq',
               icon: Icons.trending_down_rounded,
               color: AppColors.primary,
             ),
             GoalOption(
               value: 'maintain_weight',
               label: 'Çəkini Saxlamaq',
               icon: Icons.balance_rounded,
               color: AppColors.secondary,
             ),
             GoalOption(
               value: 'gain_weight',
               label: 'Kökəlmək',
               icon: Icons.fitness_center_rounded,
               color: AppColors.secondary,
             ),
           ];

  final String? selected;

  final ValueChanged<String> onChanged;

  final List<GoalOption> options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((goal) {
        final isSelected =
            selected != null &&
            selected!.toLowerCase() == goal.value.toLowerCase();
        final isLast = goal.value == options.last.value;
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
                      ? AppColors.primary.withOpacity(0.08)
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
                      goal.label,
                      textAlign: TextAlign.center,
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
