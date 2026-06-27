import 'package:flutter/material.dart';

import '../models/onboarding_data.dart';
import '../widgets/onboard_page.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onFinish();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: onboardingPages.length,
          onPageChanged: (i) => setState(() => _currentIndex = i),
          itemBuilder: (_, index) => OnboardPage(
            data: onboardingPages[index],
            currentIndex: _currentIndex,
            totalPages: onboardingPages.length,
            onNext: _next,
            onSkip: widget.onFinish,
          ),
        ),
      ),
    );
  }
}
