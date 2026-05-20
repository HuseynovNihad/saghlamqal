import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/padding_extension.dart';
import '../../../core/utils/radius_extension.dart';
import '../../../core/utils/sized_box_extension.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String initial;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
    this.initial = 'R',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.p,
      padding: 16.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary,
                child: Text(
                  initial,
                  style: AppTextStyles.h2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              14.ws,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.bodyLarge),
                    2.hs,
                    Text(
                      email,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Color(0xFF5A7A95),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
