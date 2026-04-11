import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../widgets/calorie_tip_card.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/recent_products_section.dart';
import '../widgets/scan_cta_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoggedIn = state is AuthAuthenticated;
          final name = isLoggedIn ? (state).user.name : null;

          return SingleChildScrollView(
            padding: 16.p,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(name: name),
                24.hs,
                const ScanCtaButton(),
                20.hs,
                DailyGoalCard(isLoggedIn: isLoggedIn),
                20.hs,
                CalorieTipCard(isLoggedIn: isLoggedIn),
                20.hs,
                const RecentProductsSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String? name;

  const _Header({this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name != null ? "Salam, $name 👋" : "Salam! 👋",
              style: AppTextStyles.h2,
            ),
            Text(
              "Bugün nə yeyəcəksən?",
              style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.12),
          radius: 22,
          child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22),
        ),
      ],
    );
  }
}
