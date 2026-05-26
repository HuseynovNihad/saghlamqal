import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../shared/widgets/unauthenticated_view.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/favorite_collection_card.dart';
import '../widgets/favorite_item_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritesBloc>()..add(GetFavoritesEvent()),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              return const UnauthenticatedView(
                headerIcon: AppAssets.favorite,
                title: 'Sağlam seçimlərini\nsaxla',
                subtitle:
                    'Oxutduğun məhsulları əlavə et,\nkalori və dəyərlərini izlə.',
                features: [
                  UnauthFeatureItem(
                    icon: AppAssets.favorite,
                    label: 'Məhsulları saxla',
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.collections,
                    label: 'Kolleksiyalar yarat',
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.search,
                    label: 'İstənilən vaxt tap',
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildFilterChips(),
                Expanded(
                  child: BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, state) {
                      return switch (state) {
                        FavoritesInitial() => const SizedBox.shrink(),
                        FavoritesLoading() => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        FavoritesLoaded s => _buildContent(context, s),
                        FavoriteActionLoading s => _buildContent(
                          context,
                          FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                          isActionLoading: true,
                        ),
                        FavoriteActionSuccess s => _buildContent(
                          context,
                          FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                        ),
                        FavoritesError s => _buildError(context, s.message),
                      };
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          _SearchButton(),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: 20.px,
        children: const [
          _FilterChip(label: 'Hamısı', isSelected: true),
          SizedBox(width: 8),
          _FilterChip(label: 'Son baxılanlar', isSelected: false),
          SizedBox(width: 8),
          _FilterChip(label: 'Kolleksiyalar', isSelected: false),
          SizedBox(width: 8),
          _FilterChip(label: 'Yerli məhsullar', isSelected: false),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    FavoritesLoaded state, {
    bool isActionLoading = false,
  }) {
    if (state.favorites.isEmpty && state.collections.isEmpty) {
      return _buildEmpty();
    }

    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<FavoritesBloc>().add(GetFavoritesEvent());
          },
          child: CustomScrollView(
            slivers: [
              if (state.collections.isNotEmpty) ...[
                _buildSectionLabel('Kolleksiyalar'),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: 20.px,
                      itemCount: state.collections.length,
                      separatorBuilder: (_, __) => 10.horizontalSpace,
                      itemBuilder: (context, index) {
                        return FavoriteCollectionCard(
                          collection: state.collections[index],
                          onDelete: () {
                            context.read<FavoritesBloc>().add(
                              DeleteCollectionEvent(
                                state.collections[index].id,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
              _buildSectionLabel('Saxlanılmış məhsullar'),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverList.separated(
                  itemCount: state.favorites.length,
                  separatorBuilder: (_, __) => 10.verticalSpace,
                  itemBuilder: (context, index) {
                    return FavoriteItemCard(
                      item: state.favorites[index],
                      onRemove: () {
                        context.read<FavoritesBloc>().add(
                          RemoveFavoriteEvent(state.favorites[index].id),
                        );
                      },
                      onAdd: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (isActionLoading)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(color: AppColors.primary),
          ),
      ],
    );
  }

  SliverToBoxAdapter _buildSectionLabel(String label) {
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

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: AppColors.borderColor,
          ),
          16.verticalSpace,
          const Text(
            'Hələ heç nə saxlanılmayıb',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.headline,
            ),
          ),
          8.verticalSpace,
          const Text(
            'Məhsulları tarayaraq favoritlərə əlavə et',
            style: TextStyle(fontSize: 13, color: AppColors.bodyText),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: AppColors.error,
          ),
          12.verticalSpace,
          Text(
            message,
            style: const TextStyle(color: AppColors.bodyText),
            textAlign: TextAlign.center,
          ),
          16.verticalSpace,
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


class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: const Icon(
          Icons.search_rounded,
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surface,
        borderRadius: 16.br,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.borderColor,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.bodyText,
          ),
        ),
      ),
    );
  }
}
