import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/favorite_collection_entity.dart';
import '../bloc/favorites_bloc.dart';
import 'create_collection_bottom_sheet.dart';
import 'favorite_collection_card.dart';

class FavoritesCollectionsSection extends StatelessWidget {
  final List<FavoriteCollectionEntity> collections;

  const FavoritesCollectionsSection({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: 20.px,
          itemCount: collections.length + 1,
          separatorBuilder: (_, __) => 10.ws,
          itemBuilder: (context, index) {
            if (index == collections.length) {
              return _AddCollectionCard(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: context.read<FavoritesBloc>(),
                    child: const CreateCollectionBottomSheet(),
                  ),
                ),
              );
            }
            return FavoriteCollectionCard(
              collection: collections[index],
              onDelete: () {
                context.read<FavoritesBloc>().add(
                  DeleteCollectionEvent(collections[index].id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AddCollectionCard extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCollectionCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: 16.br,
          border: Border.all(
            color: AppColors.borderColor,
            style: BorderStyle.solid,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            8.hs,
            Text(
              'Yeni',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesSectionLabel extends StatelessWidget {
  final String label;

  const FavoritesSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
        child: Text(
          label.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
