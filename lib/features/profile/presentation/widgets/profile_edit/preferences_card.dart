import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import 'activity_level_chips.dart';
import 'gender_segmented_control.dart';
import 'goal_selector.dart';
import 'section_card.dart';

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({
    super.key,
    required this.gender,
    required this.onGenderChanged,
    required this.activityLevel,
    required this.onActivityLevelChanged,
    required this.goal,
    required this.onGoalChanged,
    this.hintMessage =
        'Ardıcıllıq önəmlidir. Kiçik addımlar böyük dəyişikliklərə aparır!',
  });

  final String? gender;
  final ValueChanged<String> onGenderChanged;
  final String? activityLevel;
  final ValueChanged<String> onActivityLevelChanged;
  final String? goal;
  final ValueChanged<String> onGoalChanged;
  final String hintMessage;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.favorite_border_rounded,
      title: 'Tərcihlər',
      children: [
        Text(
          'Cins',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        8.hs,
        GenderSegmentedControl(selected: gender, onChanged: onGenderChanged),
        16.hs,
        Text(
          'Aktivlik səviyyəsi',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        8.hs,
        ActivityLevelChips(
          selected: activityLevel,
          onChanged: onActivityLevelChanged,
        ),
        16.hs,
        Text(
          'Hədəfin',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500),
        ),
        8.hs,
        GoalSelector(selected: goal, onChanged: onGoalChanged),
        16.hs,
        Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 18,
              color: AppColors.warning,
            ),
            6.ws,
            Expanded(
              child: Text(
                hintMessage,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.warning,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
