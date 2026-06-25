import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesHeader extends StatelessWidget {
  final bool isSearchOpen;
  final VoidCallback onSearchTap;

  const FavoritesHeader({
    super.key,
    required this.isSearchOpen,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favoritlər',
                style: AppTextStyles.h1.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  final count = switch (state) {
                    FavoritesLoaded s => s.favorites.length,
                    FavoriteActionLoading s => s.favorites.length,
                    FavoriteActionSuccess s => s.favorites.length,
                    _ => 0,
                  };
                  return Text(
                    '$count məhsul saxlanılıb',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          _SearchButton(isActive: isSearchOpen, onTap: onSearchTap),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _SearchButton({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Center(
          child: isActive
              ? AppAssets.close.svg(width: 16, height: 16, color: Colors.white)
              : AppAssets.search.svg(
                  width: 18,
                  height: 18,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}
