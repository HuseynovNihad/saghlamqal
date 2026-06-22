import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesErrorView extends StatelessWidget {
  final String message;

  const FavoritesErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: AppColors.error,
          ),
          12.ws,
          Text(
            message,
            style: const TextStyle(color: AppColors.bodyText),
            textAlign: TextAlign.center,
          ),
          16.ws,
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              context.read<FavoritesBloc>().add(GetFavoritesEvent());
            },
            child: const Text(
              'Yenidən cəhd et',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
