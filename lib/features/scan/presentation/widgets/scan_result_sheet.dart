import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/scan_bloc.dart';
import '../bloc/scan_state.dart';

class ScanResultSheet extends StatelessWidget {
  final VoidCallback onScanAgain;

  const ScanResultSheet({super.key, required this.onScanAgain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.p,
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
          24.hs,
          BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state is ScanLoading) return const _LoadingView();
              if (state is ScanSuccess) {
                return _SuccessView(product: state.product);
              }
              if (state is ScanNotFound) return const _NotFoundView();
              if (state is ScanError) return _ErrorView(message: state.message);
              return const SizedBox.shrink();
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
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  8.hw,
                  Text(
                    "Yenidən scan et",
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

// ── Loading ─────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(color: AppColors.primary),
        16.hs,
        Text(
          "Məhsul axtarılır...",
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

// ── Success ─────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  final ProductEntity product;

  const _SuccessView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Şəkil
        if (product.imageUrl != null)
          ClipRRect(
            borderRadius: 12.br,
            child: Image.network(
              product.imageUrl!,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const _PlaceholderImage(),
            ),
          )
        else
          const _PlaceholderImage(),
        16.hs,
        Text(
          product.name,
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (product.brand != null) ...[
          4.hs,
          Text(
            product.brand!,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
          ),
        ],
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
                label: "Kalori",
                value: product.calories?.toStringAsFixed(0) ?? '-',
                unit: "kkal",
                color: AppColors.primary,
              ),
              _NutrientItem(
                label: "Zülal",
                value: product.protein?.toStringAsFixed(1) ?? '-',
                unit: "q",
                color: Colors.blue,
              ),
              _NutrientItem(
                label: "Karbohidrat",
                value: product.carbs?.toStringAsFixed(1) ?? '-',
                unit: "q",
                color: Colors.orange,
              ),
              _NutrientItem(
                label: "Yağ",
                value: product.fat?.toStringAsFixed(1) ?? '-',
                unit: "q",
                color: Colors.red,
              ),
            ],
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
        Text(
          value,
          style: AppTextStyles.h3.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        2.hs,
        Text(unit, style: AppTextStyles.bodySmall.copyWith(color: color)),
        4.hs,
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: 12.br,
      ),
      child: Icon(Icons.fastfood_rounded, color: AppColors.primary, size: 48),
    );
  }
}

// ── Not Found ───────────────────────────────────────────

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();

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
            Icons.search_off_rounded,
            color: Colors.orange,
            size: 32,
          ),
        ),
        16.hs,
        Text(
          "Məhsul tapılmadı",
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        8.hs,
        Text(
          "Bu barkoda uyğun məhsul bazada yoxdur.",
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

// ── Error ───────────────────────────────────────────────

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
          "Xəta baş verdi",
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
