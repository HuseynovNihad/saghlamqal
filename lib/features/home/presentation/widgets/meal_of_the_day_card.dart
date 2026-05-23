import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/meal_of_the_day_entity.dart';
import '../bloc/home_bloc.dart';

class MealOfTheDayCard extends StatelessWidget {
  final HomeState state;

  const MealOfTheDayCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) {
      return const _MealSkeleton();
    }

    if (state is! HomeLoaded) return const SizedBox.shrink();

    final meal = (state as HomeLoaded).mealOfTheDay;
    if (meal == null) return const SizedBox.shrink();

    return _MealContent(meal: meal);
  }
}

class _MealContent extends StatelessWidget {
  final MealOfTheDayEntity meal;

  const _MealContent({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Positioned(
              //   top: 12,
              //   left: 12,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 10,
              //       vertical: 5,
              //     ),
              //     decoration: BoxDecoration(
              //       color: AppColors.primary.withOpacity(0.7),
              //       borderRadius: 20.br,
              //     ),
              //     child: Text(
              //       meal.tag,
              //       style: AppTextStyles.bodySmall.copyWith(
              //         color: Colors.white,
              //         fontSize: 10,
              //         fontWeight: FontWeight.w500,
              //         letterSpacing: 0.6,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: 16.p,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GÜNÜN YEMƏYİ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.0,
                  ),
                ),
                8.hs,
                Text(
                  meal.title,
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                14.hs,
                Row(
                  children: [
                    _StatItem(label: 'ENERJİ', value: '${meal.kcal} kcal'),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _StatItem(
                      label: 'MÜDDƏT',
                      value: '${meal.timeMinutes} dəq',
                    ),
                  ],
                ),
                14.hs,
                Text(
                  meal.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                14.hs,
                GestureDetector(
                  onTap: () => context.push(AppRoutes.recipe, extra: meal),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Reseptə baxın',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      4.ws,
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _MealSkeleton extends StatelessWidget {
  const _MealSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: 16.br,
      ),
    );
  }
}
