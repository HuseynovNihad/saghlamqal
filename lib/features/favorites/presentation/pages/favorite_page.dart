import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../shared/widgets/custom_text_field.dart';
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

class _FavoritesView extends StatefulWidget {
  const _FavoritesView();

  @override
  State<_FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<_FavoritesView> {
  bool _isSearchOpen = false;

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
                FavoritesHeader(
                  isSearchOpen: _isSearchOpen,
                  onSearchTap: () =>
                      setState(() => _isSearchOpen = !_isSearchOpen),
                ),
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
                        FavoritesLoaded s => _FavoritesContent(
                          state: s,
                          isSearchOpen: _isSearchOpen,
                        ),
                        FavoriteActionLoading s => _FavoritesContent(
                          state: FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                          isActionLoading: true,
                          isSearchOpen: _isSearchOpen,
                        ),
                        FavoriteActionSuccess s => _FavoritesContent(
                          state: FavoritesLoaded(
                            favorites: s.favorites,
                            collections: s.collections,
                          ),
                          isSearchOpen: _isSearchOpen,
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

class _FavoritesContent extends StatefulWidget {
  final FavoritesLoaded state;
  final bool isActionLoading;
  final bool isSearchOpen;

  const _FavoritesContent({
    required this.state,
    this.isActionLoading = false,
    required this.isSearchOpen,
  });

  @override
  State<_FavoritesContent> createState() => _FavoritesContentState();
}

class _FavoritesContentState extends State<_FavoritesContent> {
  String _query = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(_FavoritesContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isSearchOpen) {
      _controller.clear();
      _query = '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.state.favorites
        .where(
          (f) => (f.name ?? '').toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            context.read<FavoritesBloc>().add(GetFavoritesEvent());
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: widget.isSearchOpen ? 64 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: widget.isSearchOpen ? 1 : 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: CustomTextField(
                        hintText: 'Axtar...',
                        controller: _controller,
                        prefixIcon: Padding(
                          padding: 10.p,
                          child: AppAssets.search.svg(
                            width: 20,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  _controller.clear();
                                  setState(() => _query = '');
                                },
                              )
                            : null,
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                  ),
                ),
              ),
              if (filtered.isEmpty)
                const SliverFillRemaining(child: FavoritesEmptyView())
              else ...[
                const FavoritesSectionLabel(label: 'Saxlanılmış məhsullar'),
                FavoritesItemsSection(favorites: filtered),
              ],
            ],
          ),
        ),
        if (widget.isActionLoading)
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
