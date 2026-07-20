import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../water_reminder/presentation/widgets/water_reminder_card.dart';
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
    return BlocProvider<HomeBloc>.value(
      value: AppRouter.homeBloc,
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeStarted());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous is! AuthAuthenticated && current is AuthAuthenticated,
        listener: (context, authState) {
          context.read<HomeBloc>().add(const HomeStarted());
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            final isLoggedIn = authState is AuthAuthenticated;
            final name = isLoggedIn ? authState.user.firstName : null;

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
                      PhotoScanCtaButton(
                        onTap: () async {
                          await context.push(AppRoutes.photoScan);
                          if (context.mounted) {
                            context.read<HomeBloc>().add(
                              const HomeRefreshRecent(),
                            );
                          }
                        },
                      ),
                      16.hs,
                      if (!isLoggedIn) ...[
                        const GuestPreviewSection(),
                      ] else ...[
                        DailyGoalCard(state: homeState),
                        16.hs,
                        const WaterReminderCard(),
                        16.hs,
                        HydrationCard(state: homeState),
                        16.hs,
                        RecentProductsSection(state: homeState),
                      ],
                      16.hs,
                      MealOfTheDayCard(state: homeState),
                    ],
                  ),
                );
              },
            );
          },
        ),
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
              TextSpan(text: name != null ? '$name' : 'Qonaq'),
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
