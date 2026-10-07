import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesErrorView extends StatelessWidget {
  final String message;

  const FavoritesErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.error,
            ),

            12.hs,

            Text(
              message,
              style: const TextStyle(color: AppColors.bodyText),
              textAlign: TextAlign.center,
            ),

            16.hs,

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                context.read<FavoritesBloc>().add(GetFavoritesEvent());
              },
              child: Text(
                context.l10n.favoritesRetry,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
