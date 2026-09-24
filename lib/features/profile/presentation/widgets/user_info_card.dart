import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String initial;
  final String? imageUrl;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
    this.initial = 'R',
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      margin: 16.p,
      padding: 16.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: hasImage
                ? Image.network(
                    imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildInitial();
                    },
                  )
                : _buildInitial(),
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
                    color: const Color(0xFF5A7A95),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Text(
        initial.toUpperCase(),
        style: AppTextStyles.h2.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
