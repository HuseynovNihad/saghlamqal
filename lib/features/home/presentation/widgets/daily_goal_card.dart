import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/daily_goal_entity.dart';
import '../bloc/home_bloc.dart';

class DailyGoalCard extends StatelessWidget {
  final HomeState state;

  const DailyGoalCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) return const _DailyGoalSkeleton();
    if (state is HomeLoaded) {
      return _LoggedInCard(dailyGoal: (state as HomeLoaded).dailyGoal);
    }
    return const SizedBox.shrink();
  }
}

class _LoggedInCard extends StatelessWidget {
  final DailyGoalEntity dailyGoal;

  const _LoggedInCard({required this.dailyGoal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 20.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Gündəlik tövsiyə',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${dailyGoal.maintainCalories}',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  4.ws,
                  Text(
                    'kcal',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          18.hs,
          Row(
            children: [
              _MacroChip(
                label: 'Zülal',
                value: '${dailyGoal.dailyProtein}g',
                color: const Color(0xFF4ADE80),
              ),
              10.ws,
              _MacroChip(
                label: 'Karbohidrat',
                value: '${dailyGoal.dailyCarbs}g',
                color: const Color(0xFFFBBF24),
              ),
              10.ws,
              _MacroChip(
                label: 'Yağ',
                value: '${dailyGoal.dailyFat}g',
                color: const Color(0xFFF87171),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MacroChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: 14.br,
          border: Border.all(color: AppColors.borderColor, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                4.ws,
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF888888),
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            4.hs,
            Text(
              value,
              style: AppTextStyles.h2.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyGoalSkeleton extends StatelessWidget {
  const _DailyGoalSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
