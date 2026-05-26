import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../bloc/photo_scan_bloc.dart';
import 'view/photo_error_view.dart';
import 'view/photo_loading_view.dart';
import 'view/photo_not_food_view.dart';
import 'view/photo_success_view.dart';

class PhotoResultSheet extends StatelessWidget {
  final VoidCallback onScanAgain;

  const PhotoResultSheet({super.key, required this.onScanAgain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: 2.br,
            ),
          ),
          18.hs,
          BlocBuilder<PhotoScanBloc, PhotoScanState>(
            builder: (context, state) {
              return switch (state) {
                PhotoScanLoading() => const PhotoLoadingView(),
                PhotoScanSuccess(:final product) => PhotoSuccessView(
                  product: product,
                ),
                PhotoScanNotFood() => const PhotoNotFoodView(),
                PhotoScanError(:final message) => PhotoErrorView(
                  message: message,
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
          24.hs,
          GestureDetector(
            onTap: onScanAgain,
            child: Container(
              width: double.infinity,
              padding: 16.py,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: 16.br,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  8.ws,
                  Text(
                    'Yenidən çək',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.hs,
        ],
      ),
    );
  }
}
