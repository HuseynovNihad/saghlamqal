import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/sized_box_extension.dart';

class FavoritesEmptyView extends StatelessWidget {
  const FavoritesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: AppColors.borderColor,
          ),
          16.ws,
          const Text(
            'Hələ heç nə saxlanılmayıb',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.headline,
            ),
          ),
          8.ws,
          const Text(
            'Məhsulları tarayaraq favoritlərə əlavə et',
            style: TextStyle(fontSize: 13, color: AppColors.bodyText),
          ),
        ],
      ),
    );
  }
}
