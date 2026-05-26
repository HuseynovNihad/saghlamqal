import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/meal_of_the_day_entity.dart';
import '../widgets/circle_button.dart';
import '../widgets/recipe_divider.dart';
import '../widgets/section_title.dart';
import '../widgets/stats_row.dart';

class RecipePage extends StatelessWidget {
  final MealOfTheDayEntity meal;

  const RecipePage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 18),
                  _buildMainStats(),
                  const SizedBox(height: 12),
                  _buildMacroStats(),
                  const SizedBox(height: 24),
                  const RecipeDivider(),
                  const SizedBox(height: 24),
                  _buildIngredients(),
                  const SizedBox(height: 28),
                  _buildSteps(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: CircleButton(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
          color: Colors.black87,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(meal.imageUrl, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GÜNÜN YEMƏYİ',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 10,
            letterSpacing: 1.1,
          ),
        ),
        8.hs,
        Text(
          meal.title,
          style: AppTextStyles.h2.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        8.hs,
        Text(
          meal.description,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey.shade600,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMainStats() {
    return StatsRow(
      cells: [
        StatCell(label: 'ENERJİ', value: '${meal.kcal}', unit: 'kcal'),
        StatCell(label: 'MÜDDƏT', value: '${meal.timeMinutes}', unit: 'dəq'),
        StatCell(label: 'PORSİYA', value: '${meal.servings}', unit: 'nəfər'),
      ],
    );
  }

  Widget _buildMacroStats() {
    return StatsRow(
      cells: [
        StatCell(label: 'ZÜLAL', value: '${meal.protein}', unit: 'q'),
        StatCell(label: 'KARBOHİDRAT', value: '${meal.carbs}', unit: 'q'),
        StatCell(label: 'YAĞ', value: '${meal.fat}', unit: 'q'),
      ],
    );
  }

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(icon: AppAssets.ingredient, label: 'Tərkiblər'),
        12.hs,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor, width: 0.8),
            borderRadius: 16.br,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(meal.ingredients.length, (i) {
              final ing = meal.ingredients[i];
              final isEven = i % 2 == 0;
              return Container(
                color: isEven ? Colors.white : Colors.grey.shade50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        ing.name,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        ing.amount,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(icon: AppAssets.list, label: 'Hazırlama mərhələləri'),
        12.hs,
        Column(
          children: List.generate(meal.steps.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        meal.steps[i],
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 13.5,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
