import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../widgets/calorie_tip_card.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/meal_of_the_day_card.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(name: name),
                24.hs,
                const ScanCtaButton(),
                20.hs,
                DailyGoalCard(isLoggedIn: isLoggedIn),
                20.hs,
                HydrationCard(isLoggedIn: isLoggedIn),
                20.hs,
                const RecentProductsSection(),
                20.hs,
                MealOfTheDayCard(
                  mealTitle: 'Avocado & Salmon Power Bowl',
                  imageUrl:
                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
                  kcal: 420,
                  timeMinutes: 15,
                  description:
                      'High in Omega-3s and fiber to sustain your energy levels through the afternoon slump.',
                  onGetRecipe: () {
                    // naviqasiya
                  },
                ),
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
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1.15,
              letterSpacing: -0.5,
            ),
            children: [
              TextSpan(text: '$_greeting,\n'),
              TextSpan(text: name != null ? '$name.' : 'Qonaq.'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Bugünkü hekayən başlamağa hazırdır.',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
