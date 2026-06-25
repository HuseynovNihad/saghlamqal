import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../domain/entities/about_us_section_entity.dart';

class AboutUsSectionCard extends StatelessWidget {
  final AboutUsSectionEntity section;

  const AboutUsSectionCard({super.key, required this.section});

  String get _emoji => switch (section.icon) {
    'leaf' => '🌿',
    'heart' => '❤️',
    'users' => '👥',
    _ => '✦',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 12.pb,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.br,
          border: Border.all(color: AppColors.borderColor, width: 0.8),
        ),
        child: Padding(
          padding: 12.p,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: 12.br,
                ),
                child: Center(
                  child: Text(_emoji, style: const TextStyle(fontSize: 18)),
                ),
              ),
              14.ws,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    6.hs,
                    Text(
                      section.text,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: const Color(0xFF666666),
                        height: 1.55,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
