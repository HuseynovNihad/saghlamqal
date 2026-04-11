import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/guest_lock_card.dart';

class DailyGoalCard extends StatelessWidget {
  final bool isLoggedIn;

  const DailyGoalCard({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? const _LoggedInCard()
        : const GuestLockCard(
            title: "Gündəlik Kalori Ehtiyacı",
            message:
                "Daxil ol, sənin üçün gündəlik kalori ehtiyacını hesablayaq.",
          );
  }
}

class _LoggedInCard extends StatelessWidget {
  const _LoggedInCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 16.p,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: 16.br,
      ),
      child: Row(
        children: [
          Container(
            padding: 12.p,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: 12.br,
            ),
            child: const Text("🔥", style: TextStyle(fontSize: 22)),
          ),
          14.hw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gündəlik Tövsiyə",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                4.hs,
                Text(
                  "1850 kkal",
                  style: AppTextStyles.h2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                2.hs,
                Text(
                  "Sizin üçün tövsiyə olunan gündəlik kalori",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
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
