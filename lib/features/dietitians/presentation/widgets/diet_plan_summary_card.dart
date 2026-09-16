import 'package:flutter/material.dart';

import '../../domain/entities/daily_meal_check_ins_entity.dart';
import '../../domain/entities/patient_diet_plan_entity.dart';

class DietPlanSummaryCard extends StatelessWidget {
  final PatientDietPlanEntity dietPlan;
  final DailyMealCheckInsEntity? dailyCheckIns;
  final bool isCheckInsLoading;
  final VoidCallback? onTap;

  const DietPlanSummaryCard({
    super.key,
    required this.dietPlan,
    this.dailyCheckIns,
    this.isCheckInsLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final completedMeals = dailyCheckIns?.completedMeals ?? 0;

    final totalMeals = dailyCheckIns?.totalMeals ?? 0;

    final percentage = dailyCheckIns?.completionPercentage ?? 0;

    final progress = (percentage / 100).clamp(0.0, 1.0).toDouble();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFBFCFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE9EEEE)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE9F8EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.eco_outlined,
                    color: Color(0xFF24A763),
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dietPlan.dietPlan.title.isNotEmpty
                            ? dietPlan.dietPlan.title
                            : 'Aktiv diet planın',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF153A45),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        _buildDateText(),
                        style: const TextStyle(
                          color: Color(0xFF7B8D93),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF809096),
                ),
              ],
            ),

            const SizedBox(height: 14),

            if (isCheckInsLoading)
              const SizedBox(
                height: 7,
                child: LinearProgressIndicator(
                  backgroundColor: Color(0xFFE2E8E8),
                ),
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 7,
                            backgroundColor: const Color(0xFFE2E8E8),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF20B764),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '${percentage.toStringAsFixed(0)}% tamamlanıb',
                          style: const TextStyle(
                            color: Color(0xFF7B8D93),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$completedMeals/$totalMeals',
                        style: const TextStyle(
                          color: Color(0xFF153A45),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'bugünkü yemək',
                        style: TextStyle(
                          color: Color(0xFF7B8D93),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _buildDateText() {
    final start = dietPlan.startDate;
    final end = dietPlan.endDate;

    if (start.isEmpty || end.isEmpty) {
      return 'Plan aktivdir';
    }

    return '$start — $end';
  }
}
