import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class DietitiansDiscoverTab extends StatefulWidget {
  const DietitiansDiscoverTab({super.key});

  @override
  State<DietitiansDiscoverTab> createState() => _DietitiansDiscoverTabState();
}

class _DietitiansDiscoverTabState extends State<DietitiansDiscoverTab> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  static const List<_DietitianMock> _dietitians = [
    _DietitianMock(
      name: 'Aygün Məmmədova',
      title: 'Klinik Dietoloq',
      clinic: 'Healthy Life Klinikası',
      rating: 4.9,
      reviews: 120,
      initials: 'AM',
    ),
    _DietitianMock(
      name: 'Elvin Əliyev',
      title: 'İdman Qidalanması Mütəxəssisi',
      clinic: 'FitLife Mərkəzi',
      rating: 4.8,
      reviews: 94,
      initials: 'EƏ',
    ),
    _DietitianMock(
      name: 'Nigar Həsənova',
      title: 'Pediatrik Dietoloq',
      clinic: 'Uşaq Sağlamlıq Mərkəzi',
      rating: 4.9,
      reviews: 76,
      initials: 'NH',
    ),
    _DietitianMock(
      name: 'Rəşad Kərimov',
      title: 'Klinik Dietoloq',
      clinic: 'Sağlam Yaşam Klinika',
      rating: 4.7,
      reviews: 61,
      initials: 'RK',
    ),
  ];

  List<_DietitianMock> get _filteredDietitians {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return _dietitians;
    }

    return _dietitians.where((dietitian) {
      return dietitian.name.toLowerCase().contains(query) ||
          dietitian.title.toLowerCase().contains(query) ||
          dietitian.clinic.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dietitians = _filteredDietitians;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 125),
      physics: const BouncingScrollPhysics(),
      children: [
        _SearchBar(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          onFilterTap: () {
            // TODO: Filter əlavə ediləndə burada açılacaq.
          },
        ),

        const SizedBox(height: 18),

        _DiscoverBanner(
          onTap: () {
            // Artıq discover tabındayıq.
          },
        ),

        const SizedBox(height: 26),

        _SectionHeader(
          title: _searchQuery.isEmpty
              ? 'Populyar dietoloqlar'
              : 'Axtarış nəticələri',
          trailing: _searchQuery.isEmpty ? 'Hamısını gör' : null,
          onTap: () {
            // TODO: Real API gələndə bütün dietoloqlar.
          },
        ),

        const SizedBox(height: 12),

        if (dietitians.isEmpty)
          const _EmptySearch()
        else
          ...List.generate(dietitians.length, (index) {
            final dietitian = dietitians[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == dietitians.length - 1 ? 0 : 11,
              ),
              child: _DietitianListCard(
                dietitian: dietitian,
                onTap: () {
                  // TODO: Dietitian detail page.
                },
                onFavoriteTap: () {
                  // TODO: Favorite API.
                },
              ),
            );
          }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SEARCH
// ─────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Dietoloq axtar...',
                hintStyle: TextStyle(
                  color: Colors.blueGrey.shade400,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF173B46),
                  size: 24,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 17),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onFilterTap,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.tune_rounded, color: Color(0xFF173B46)),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// BANNER
// ─────────────────────────────────────────────────────────────

class _DiscoverBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const _DiscoverBanner({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.fromLTRB(20, 22, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE6F8EE), Color(0xFFD7F1E3)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            bottom: -20,
            child: Icon(
              Icons.eco_rounded,
              size: 170,
              color: Colors.white.withValues(alpha: 0.38),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 220,
                child: Text(
                  'Hədəflərinə\nbirlikdə çataq',
                  style: TextStyle(
                    color: Color(0xFF153A45),
                    fontSize: 25,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const SizedBox(
                width: 220,
                child: Text(
                  'Peşəkar dietoloqlarla daha sağlam '
                  'bir gələcək qur.',
                  style: TextStyle(
                    color: Color(0xFF41615A),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF174D48),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dietoloqları kəşf et',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DIETITIAN CARD
// ─────────────────────────────────────────────────────────────

class _DietitianListCard extends StatelessWidget {
  final _DietitianMock dietitian;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const _DietitianListCard({
    required this.dietitian,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withValues(alpha: 0.035)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            _Avatar(initials: dietitian.initials, size: 64),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          dietitian.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF112B36),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      Container(
                        width: 17,
                        height: 17,
                        decoration: const BoxDecoration(
                          color: Color(0xFF21B968),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    dietitian.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    dietitian.clinic,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blueGrey.shade500,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFFFB224),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${dietitian.rating} '
                        '(${dietitian.reviews} rəy)',
                        style: TextStyle(
                          color: Colors.blueGrey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            IconButton(
              onPressed: onFavoriteTap,
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFA4B3B4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  const _SectionHeader({required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF112F38),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        if (trailing != null)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailing!,
                    style: const TextStyle(
                      color: Color(0xFF1FA862),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF1FA862),
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// EMPTY
// ─────────────────────────────────────────────────────────────

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 46,
            color: Colors.blueGrey.shade300,
          ),
          const SizedBox(height: 12),
          const Text(
            'Dietoloq tapılmadı',
            style: TextStyle(
              color: Color(0xFF153A45),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Başqa ad və ya ixtisasla axtar.',
            style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AVATAR
// ─────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  final String initials;
  final double size;

  const _Avatar({required this.initials, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F0),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: size * 0.27,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TEMP MODEL
// ─────────────────────────────────────────────────────────────

class _DietitianMock {
  final String name;
  final String title;
  final String clinic;
  final double rating;
  final int reviews;
  final String initials;

  const _DietitianMock({
    required this.name,
    required this.title,
    required this.clinic,
    required this.rating,
    required this.reviews,
    required this.initials,
  });
}
