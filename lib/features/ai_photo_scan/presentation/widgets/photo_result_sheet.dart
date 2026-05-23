import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/photo_product_entity.dart';
import '../bloc/photo_scan_bloc.dart';

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
                PhotoScanLoading() => const _LoadingView(),
                PhotoScanSuccess(:final product) => _SuccessView(
                  product: product,
                ),
                PhotoScanNotFood() => const _NotFoodView(),
                PhotoScanError(:final message) => _ErrorView(message: message),
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

// ── Loading ──────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(color: AppColors.primary),
        16.hs,
        Text(
          'Təhlil edilir...',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

// ── Success ──────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  final PhotoProductEntity product;

  const _SuccessView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          product.name,
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        20.hs,
        Container(
          width: double.infinity,
          padding: 16.p,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: 16.br,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutrientItem(
                label: 'Kalori',
                value: product.calories?.toStringAsFixed(0) ?? '-',
                unit: 'kkal',
                color: AppColors.primary,
              ),
              _VerticalDivider(),
              _NutrientItem(
                label: 'Zülal',
                value: product.protein?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.blue,
              ),
              _VerticalDivider(),
              _NutrientItem(
                label: 'Karbohidrat',
                value: product.carbs?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.orange,
              ),
              _VerticalDivider(),
              _NutrientItem(
                label: 'Yağ',
                value: product.fat?.toStringAsFixed(1) ?? '-',
                unit: 'q',
                color: Colors.red,
              ),
            ],
          ),
        ),
        16.hs,
        Container(
          width: double.infinity,
          padding: 16.p,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: 16.br,
          ),
          child: Text(
            product.advice,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.green.shade800,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _NutrientItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _NutrientItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTextStyles.h3.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.ws,
            Text(unit, style: AppTextStyles.bodySmall.copyWith(color: color)),
          ],
        ),
        4.hs,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

// ── Error ────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 32,
          ),
        ),
        16.hs,
        Text(
          'Xəta baş verdi',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        8.hs,
        Text(
          message,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _NotFoodView extends StatelessWidget {
  const _NotFoodView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.no_food_rounded,
            color: Colors.orange,
            size: 32,
          ),
        ),
        16.hs,
        Text(
          'Qida aşkarlanmadı',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        8.hs,
        Text(
          'Zəhmət olmasa yeyəcək və ya içəcək şəklini çəkin.',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 50, color: Colors.grey.shade200);
  }
}
