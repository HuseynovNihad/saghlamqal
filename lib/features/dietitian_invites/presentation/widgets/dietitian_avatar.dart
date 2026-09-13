import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DietitianAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const DietitianAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl?.trim().isNotEmpty ?? false;

    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _InitialsAvatar(name: name);
                },
              )
            : _InitialsAvatar(name: name),
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String name;

  const _InitialsAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _getInitials(name),
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _getInitials(String value) {
    final parts = value
        .trim()
        .split(' ')
        .where((item) => item.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return 'D';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
