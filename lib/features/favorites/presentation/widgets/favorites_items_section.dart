import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/favorite_item_entity.dart';
import '../bloc/favorites_bloc.dart';
import 'favorite_item_card.dart';

class FavoritesItemsSection extends StatelessWidget {
  final List<FavoriteItemEntity> favorites;

  const FavoritesItemsSection({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      sliver: SliverList.separated(
        itemCount: favorites.length,
        separatorBuilder: (_, __) => 10.hs,
        itemBuilder: (context, index) {
          final favorite = favorites[index];

          return FavoriteItemCard(
            item: favorite,
            onRemove: () {
              context.read<FavoritesBloc>().add(
                RemoveFavoriteEvent(favorite.id),
              );
            },
            onAdd: () {},
          );
        },
      ),
    );
  }
}
