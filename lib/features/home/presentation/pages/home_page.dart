import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/home_bloc.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/guest_preview_section.dart';
import '../widgets/hydration_card.dart';
import '../widgets/meal_of_the_day_card.dart';
import '../widgets/photo_scan_cta_button.dart';
import '../widgets/recent_products_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final isLoggedIn = authState is AuthAuthenticated;
          final name = isLoggedIn ? authState.user.name : null;

          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(name: name),
                    24.hs,
                    const PhotoScanCtaButton(),
                    20.hs,
                    if (isLoggedIn) ...[
                      const GuestPreviewSection(),
                    ] else ...[
                      DailyGoalCard(isLoggedIn: true, state: homeState),
                      20.hs,
                      HydrationCard(isLoggedIn: true, state: homeState),
                      20.hs,
                      RecentProductsSection(isLoggedIn: true, state: homeState),
                    ],
                    20.hs,
                    MealOfTheDayCard(state: homeState),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String? name;

  const _Header({this.name});

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Sabahınız xeyir';
    if (hour < 17) return 'Günortanız xeyir';
    return 'Axşamınız xeyir';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.15,
              letterSpacing: -0.5,
            ),
            children: [
              TextSpan(text: '$_greeting,\n'),
              TextSpan(text: name != null ? '$name.' : 'Qonaq'),
            ],
          ),
        ),
        6.hs,
        Text(
          'Bugünkü hekayən başlamağa hazırdır.',
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
