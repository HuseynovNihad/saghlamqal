import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/unauthenticated_view.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/favorites_collections_section.dart';
import '../widgets/favorites_empty_view.dart';
import '../widgets/favorites_error_view.dart';
import '../widgets/favorites_header.dart';
import '../widgets/favorites_items_section.dart';

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
            if (authState is! AuthAuthenticated) {
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
                const FavoritesHeader(),
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
                        FavoritesLoaded s => _FavoritesContent(state: s),
                        FavoriteActionLoading s => _FavoritesContent(
                          state: FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                          isActionLoading: true,
                        ),
                        FavoriteActionSuccess s => _FavoritesContent(
                          state: FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                        ),
                        FavoritesError s => FavoritesErrorView(
                          message: s.message,
                        ),
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
}

class _FavoritesContent extends StatelessWidget {
  final FavoritesLoaded state;
  final bool isActionLoading;

  const _FavoritesContent({required this.state, this.isActionLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<FavoritesBloc>().add(GetFavoritesEvent());
          },
          child: CustomScrollView(
            slivers: [
              const FavoritesSectionLabel(label: 'Kolleksiyalar'),
              FavoritesCollectionsSection(collections: state.collections),
              if (state.favorites.isEmpty)
                const SliverFillRemaining(child: FavoritesEmptyView())
              else ...[
                const FavoritesSectionLabel(label: 'Saxlanılmış məhsullar'),
                FavoritesItemsSection(favorites: state.favorites),
              ],
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
}
