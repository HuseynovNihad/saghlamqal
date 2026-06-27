import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../models/onboarding_data.dart';
import 'onboard_bottom_panel.dart';

class OnboardPage extends StatelessWidget {
  final OnboardingData data;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardPage({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final panelHeight = size.height * 0.38;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            data.image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.onboardPanelDark,
                  AppColors.onboardPanelDark.withOpacity(0.92),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.3, 0.6],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: panelHeight,
          child: OnboardBottomPanel(
            data: data,
            currentIndex: currentIndex,
            totalPages: totalPages,
            onNext: onNext,
            onSkip: onSkip,
          ),
        ),
      ],
    );
  }
}
