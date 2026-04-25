import 'package:flutter/material.dart';

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
    return !isLoggedIn
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

  static const int _dailyKcal = 2200;

  static const int _proteinRec = 165;

  static const int _carbsRec = 275;

  static const int _fatsRec = 73;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 20.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: Colors.grey.withOpacity(0.12), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "GÜNDƏLIK TÖVSIYƏ",
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey.shade500,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          6.hs,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$_dailyKcal",
                style: AppTextStyles.h1.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              6.ws,
              Padding(
                padding: 8.pb,
                child: Text(
                  "kcal",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          20.hs,
          const Divider(thickness: 0.5, height: 1),
          20.hs,
          _MacroRow(label: "ZÜLAL", recommended: _proteinRec, unit: "g"),
          16.hs,
          _MacroRow(label: "KARBOHİDRAT", recommended: _carbsRec, unit: "g"),
          16.hs,
          _MacroRow(label: "YAĞ", recommended: _fatsRec, unit: "g"),
        ],
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final String label;
  final int recommended;
  final String unit;

  const _MacroRow({
    required this.label,
    required this.recommended,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
            letterSpacing: 0.6,
          ),
        ),
        4.hs,
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "$recommended$unit",
              style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w600),
            ),
            4.ws,
            Padding(
              padding: 3.pb,
              child: Text(
                "töv.",
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
