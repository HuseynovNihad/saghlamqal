import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/shimmer_box.dart';
import '../../domain/entities/recent_product_entity.dart';
import '../bloc/home_bloc.dart';
import '../widgets/recent_product_card.dart';

class RecentProductsSection extends StatelessWidget {
  final HomeState state;

  const RecentProductsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final products = state is HomeLoaded
        ? (state as HomeLoaded).recentProducts
        : <RecentProductEntity>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Son oxudulanlar',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (products.isNotEmpty)
              GestureDetector(
                onTap: () =>
                    context.push(AppRoutes.recentProducts, extra: products),
                child: Text(
                  'Hamısına bax',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
          ],
        ),
        12.hs,
        if (state is HomeLoading)
          const _RecentProductsSkeleton()
        else if (products.isEmpty)
          const _EmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length.clamp(0, 5),
            separatorBuilder: (_, __) => 10.hs,
            itemBuilder: (context, index) =>
                RecentProductCard(product: products[index]),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 16.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.qr_code_2_rounded,
              size: 32,
              color: Colors.grey.shade400,
            ),
          ),
          16.hs,
          Text(
            'Hələ heç bir məhsul\noxudulmayıb',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          8.hs,
          Text(
            'Məhsulları əlavə etmək üçün barkodu scan\nedin',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey.shade400,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          20.hs,
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.barcode_reader,
                size: 18,
                color: Colors.white,
              ),
              label: Text(
                'İndi scan et',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentProductsSkeleton extends StatelessWidget {
  const _RecentProductsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: 10.pb,
          child: Container(
            padding: 14.p,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: 16.br,
              border: Border.all(color: AppColors.borderColor, width: 0.8),
            ),
            child: Row(
              children: [
                ShimmerBox(width: 52, height: 52, radius: 12),
                12.ws,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(width: double.infinity, height: 14, radius: 6),
                      8.hs,
                      ShimmerBox(width: 100, height: 12, radius: 6),
                    ],
                  ),
                ),
                12.ws,
                ShimmerBox(width: 48, height: 28, radius: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
