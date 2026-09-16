import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class DietitianAvatar extends StatelessWidget {
  final String initials;
  final String? imageUrl;
  final double size;

  const DietitianAvatar({
    super.key,
    required this.initials,
    required this.size,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F0),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: hasImage
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return _Initials(initials: initials, size: size);
              },
            )
          : _Initials(initials: initials, size: size),
    );
  }
}

class _Initials extends StatelessWidget {
  final String initials;
  final double size;

  const _Initials({required this.initials, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: size * 0.27,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
