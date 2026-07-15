import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/sized_box_extension.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSteps * 2 - 1, (index) {
            if (index.isOdd) {
              final stepBeforeLine = index ~/ 2;
              final isCompleted = stepBeforeLine < currentStep;
              return Container(
                width: 28,
                height: 2,
                color: isCompleted ? AppColors.secondary : Colors.grey.shade300,
              );
            }
            final step = index ~/ 2;
            final isCompleted = step < currentStep;
            final isCurrent = step == currentStep;
            return _StepCircle(
              number: step + 1,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
            );
          }),
        ),
        12.hs,
        Text(
          "Qeydiyyat ${currentStep + 1} / $totalSteps",
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  final int number;
  final bool isCompleted;
  final bool isCurrent;

  const _StepCircle({
    required this.number,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final active = isCompleted || isCurrent;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.secondary : Colors.white,
        border: Border.all(
          color: active ? AppColors.secondary : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: isCompleted
          ? const Icon(Icons.check, color: Colors.white, size: 18)
          : Text(
              "$number",
              style: TextStyle(
                color: isCurrent ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
    );
  }
}
