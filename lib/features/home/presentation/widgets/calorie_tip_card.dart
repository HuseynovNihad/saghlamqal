import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/guest_lock_card.dart';

class CalorieTipCard extends StatelessWidget {
  final bool isLoggedIn;

  const CalorieTipCard({super.key, required this.isLoggedIn});

  static const List<String> _tips = [
    "Gün ərzində ən az 2 litr su iç. Su həzmi sürətləndirir və tox hiss etdirir. 💧",
    "Səhər yeməyini atlamaq gün boyu həddindən artıq yemək iştahına səbəb ola bilər. 🌅",
    "Zülal baxımından zəngin qidalar daha uzun müddət tox saxlayır. 🥚",
    "Yavaş ye — beyinin tox siqnalı göndərməsi 20 dəqiqə çəkir. 🍽️",
    "Gecə 20:00-dan sonra ağır qidalardan çəkin. 🌙",
  ];

  String get _todayTip {
    final dayIndex = DateTime.now().day % _tips.length;
    return _tips[dayIndex];
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const GuestLockCard(
        title: "Kalori Tövsiyəsi",
        message: "Daxil ol, sənə xüsusi sağlam həyat məsləhətləri verək.",
      );
    }

    return Container(
      width: double.infinity,
      padding: 16.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("💡", style: TextStyle(fontSize: 16)),
              6.hw,
              Text(
                "Kalori Tövsiyəsi",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          12.hs,
          Text(
            _todayTip,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
