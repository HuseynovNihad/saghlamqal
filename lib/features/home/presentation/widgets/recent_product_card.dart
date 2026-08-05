import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../domain/entities/recent_product_entity.dart';
import 'recent_product_macro.dart';

class RecentProductCard extends StatefulWidget {
  final RecentProductEntity product;

  const RecentProductCard({super.key, required this.product});

  @override
  State<RecentProductCard> createState() => _RecentProductCardState();
}

class _RecentProductCardState extends State<RecentProductCard> {
  late bool _isFavorite;
  String? _favoriteId;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.product.isFavorite;
    _favoriteId = widget.product.favoriteId;
  }

  @override
  void didUpdateWidget(covariant RecentProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.product.id != widget.product.id ||
        oldWidget.product.isFavorite != widget.product.isFavorite ||
        oldWidget.product.favoriteId != widget.product.favoriteId) {
      _isFavorite = widget.product.isFavorite;
      _favoriteId = widget.product.favoriteId;
    }
  }

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(localDate.year, localDate.month, localDate.day);
    final timeStr =
        '${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}';

    if (dateOnly == today) return 'Bugün, $timeStr';

    final yesterday = today.subtract(const Duration(days: 1));
    if (dateOnly == yesterday) return 'Dünən, $timeStr';

    return '${localDate.day.toString().padLeft(2, '0')}.${localDate.month.toString().padLeft(2, '0')}.${localDate.year}, $timeStr';
  }

  void _onFavoriteToggle(BuildContext context, FavoritesBloc favoritesBloc) {
    final product = widget.product;

    if (_isFavorite) {
      if (_favoriteId != null) {
        favoritesBloc.add(RemoveFavoriteEvent(_favoriteId!));
      }
      setState(() {
        _isFavorite = false;
        _favoriteId = null;
      });

      CustomSnackBar.show(
        context,
        message: '${product.name ?? 'Məhsul'} favoritlərdən silindi',
        type: SnackBarType.info,
      );
    } else {
      favoritesBloc.add(
        AddFavoriteEvent(
          name: product.name ?? 'Məhsul',
          icon: product.icon,
          calories: product.calories,
          protein: product.protein,
          carbs: product.carbs,
          fat: product.fat,
          vitamins: product.vitamins,
          advice: product.advice,
          isFood: true,
          servingSize: product.servingSize?.toInt(),
          servingUnit: product.servingUnit,
          historyId: product.id,
        ),
      );
      setState(() => _isFavorite = true);

      CustomSnackBar.show(
        context,
        message: '${product.name ?? 'Məhsul'} favoritlərə əlavə edildi',
        type: SnackBarType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, favState) {
        if (favState is FavoriteActionSuccess &&
            _isFavorite &&
            _favoriteId == null) {
          final added = favState.favorites.isNotEmpty
              ? favState.favorites.last
              : null;
          if (added != null) {
            setState(() => _favoriteId = added.id);
          }
        }
      },
      builder: (context, favState) {
        final favoritesBloc = context.read<FavoritesBloc>();

        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: 20.br,
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            product.icon ?? '🍽️',
                            style: const TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      12.ws,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.name ?? 'Məhsul',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  8.ws,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF7EE),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${product.calories} KKAL',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: const Color(0xFF34A853),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              8.hs,
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    RecentProductMacro(
                                      label: 'ZÜLAL',
                                      value: '${product.protein}g',
                                      color: const Color(0xFFE05C3A),
                                    ),
                                    8.ws,
                                    VerticalDivider(
                                      color: AppColors.borderColor,
                                      thickness: 0.8,
                                      width: 1,
                                    ),
                                    8.ws,
                                    RecentProductMacro(
                                      label: 'KARBO',
                                      value: '${product.carbs}g',
                                      color: const Color(0xFF2F7BE8),
                                    ),
                                    8.ws,
                                    VerticalDivider(
                                      color: AppColors.borderColor,
                                      thickness: 0.8,
                                      width: 1,
                                    ),
                                    8.ws,
                                    RecentProductMacro(
                                      label: 'YAĞ',
                                      value: '${product.fat}g',
                                      color: const Color(0xFFF5A623),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (product.vitamins != null &&
                      product.vitamins!.entries.any(
                        (e) => e.value != null,
                      )) ...[
                    12.hs,
                    Divider(
                      color: AppColors.borderColor,
                      thickness: 0.5,
                      height: 0.7,
                    ),
                    12.hs,
                    Text(
                      'Vitaminlər',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF77787F),
                      ),
                    ),
                    6.hs,
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: product.vitamins!.entries
                          .where((e) => e.value != null)
                          .map((e) {
                            final value = e.value!;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F3F5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${e.key}: ${value % 1 == 0 ? value.toInt() : value}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ],
                  12.hs,
                  Divider(
                    color: AppColors.borderColor,
                    thickness: 0.5,
                    height: 0.7,
                  ),
                  12.hs,
                  Row(
                    children: [
                      AppAssets.calendar.svg(
                        height: 14,
                        width: 14,
                        color: Colors.grey,
                      ),
                      6.ws,
                      Text(
                        _formatDate(product.createdAt),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => _onFavoriteToggle(context, favoritesBloc),
                child: _isFavorite
                    ? AppAssets.favoriteFill.svg(height: 22, width: 22)
                    : AppAssets.favorite.svg(
                        height: 20,
                        width: 20,
                        color: Colors.grey.shade400,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
