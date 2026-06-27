import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/padding_extension.dart';
import '../../../core/utils/radius_extension.dart';
import '../../../core/utils/sized_box_extension.dart';
import '../models/onboarding_data.dart';
import 'onboard_title.dart';

class OnboardBottomPanel extends StatelessWidget {
  final OnboardingData data;
  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardBottomPanel({
    super.key,
    required this.data,
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.px,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          28.hs,
          OnboardTitle(
            title: data.title,
            titleHighlight: data.titleHighlight,
            emoji: data.titleEmoji,
          ),
          8.hs,
          _Subtitle(text: data.subtitle),
          24.hs,
          _DotIndicator(activeIndex: currentIndex, count: totalPages),
          16.hs,
          _CtaButton(label: data.buttonLabel, onPressed: onNext),
          8.hs,
          if (currentIndex < totalPages - 1) _SkipLink(onTap: onSkip),
        ],
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String text;
  const _Subtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.surface.withOpacity(0.85),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;
  const _DotIndicator({required this.activeIndex, required this.count});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.onboardLightGreen,
          dotColor: AppColors.surface.withOpacity(0.3),
          dotHeight: 7,
          dotWidth: 7,
          expansionFactor: 3,
          spacing: 6,
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _CtaButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onboardAccentGreen,
          foregroundColor: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: 16.br),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            4.ws,
            const Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SkipLink extends StatelessWidget {
  final VoidCallback onTap;
  const _SkipLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: 4.py,
          child: Text(
            'Keç →',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onboardSkipGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
