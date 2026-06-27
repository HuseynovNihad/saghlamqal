import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardHeroImage extends StatelessWidget {
  final String imagePath;
  final double height;

  const OnboardHeroImage({
    super.key,
    required this.imagePath,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.onboardPanelDark.withOpacity(0.85),
                    AppColors.onboardPanelDark,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
