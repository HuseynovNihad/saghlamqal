import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DietitiansPage extends StatefulWidget {
  const DietitiansPage({super.key});

  @override
  State<DietitiansPage> createState() => _DietitiansPageState();
}

class _DietitiansPageState extends State<DietitiansPage> {
  int _selectedTab = 0;

  static const _dietitians = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),

            _buildSegmentedControl(),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _selectedTab == 0
                    ? _buildMyDietitianPage()
                    : _buildDiscoverPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dietoloqlar',
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Daha sağlam bir sən üçün doğru dietoloqu tap.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: Colors.blueGrey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 24,
                  color: Color(0xFF173B46),
                ),
              ),

              Positioned(
                top: -4,
                right: -3,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5353),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEGMENTED CONTROL
  // ============================================================

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 6, 20, 20),
      padding: const EdgeInsets.all(4),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(child: _segmentButton(index: 0, label: 'Mənim dietoloqum')),
          Expanded(
            child: _segmentButton(index: 1, label: 'Dietoloqları kəşf et'),
          ),
        ],
      ),
    );
  }

  Widget _segmentButton({required int index, required String label}) {
    final selected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        if (_selectedTab == index) return;

        setState(() {
          _selectedTab = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF173B46),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }

  // ============================================================
  // MY DIETITIAN TAB
  // ============================================================

  Widget _buildMyDietitianPage() {
    return ListView(
      key: const ValueKey('my-dietitian'),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 125),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSectionHeader(
          title: 'Gələn dəvətlər',
          badge: '1',
          trailing: 'Hamısını gör',
          onTap: () {},
        ),

        const SizedBox(height: 12),

        _buildInviteCard(),

        const SizedBox(height: 28),

        _buildSectionHeader(title: 'Mənim dietoloqum'),

        const SizedBox(height: 12),

        _buildMyDietitianCard(),

        const SizedBox(height: 18),

        _buildTipCard(),
      ],
    );
  }

  Widget _buildInviteCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withValues(alpha: 0.035)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(initials: 'AM', size: 64),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Aygün Məmmədova',
                            style: TextStyle(
                              color: Color(0xFF112B36),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '2 gün əvvəl',
                          style: TextStyle(
                            color: Colors.blueGrey.shade400,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Klinik Dietoloq',
                      style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Healthy Life Klinikası',
                      style: TextStyle(
                        color: Colors.blueGrey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 47,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF5353),
                      side: const BorderSide(color: Color(0xFFFF6B6B)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text(
                      'İmtina et',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Text(
                      'Qəbul et',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyDietitianCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black.withValues(alpha: 0.035)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 14, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(initials: 'AM', size: 72),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Flexible(
                            child: Text(
                              'Aygün Məmmədova',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF112B36),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          const SizedBox(width: 5),

                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFF21B968),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        'Klinik Dietoloq',
                        style: TextStyle(
                          color: Colors.blueGrey.shade600,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Healthy Life Klinikası',
                        style: TextStyle(
                          color: Colors.blueGrey.shade500,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F8EF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 14,
                              color: Color(0xFF20A85B),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Aktiv əlaqə',
                              style: TextStyle(
                                color: Color(0xFF208E51),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 28),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF173B46),
                    size: 26,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.restaurant_menu_rounded,
                    label: 'Diet planım',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Mesaj yaz',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.calendar_month_outlined,
                    label: 'Görüşlər',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildQuickAction(
                    icon: Icons.badge_outlined,
                    label: 'Profilə bax',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFCFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE9EEEE)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE9F8EF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.eco_outlined,
                        color: Color(0xFF24A763),
                      ),
                    ),

                    const SizedBox(width: 11),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Planın davam edir',
                            style: TextStyle(
                              color: Color(0xFF153A45),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '3 həftədir aktivdir',
                            style: TextStyle(
                              color: Color(0xFF7B8D93),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF809096),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const LinearProgressIndicator(
                          value: 0.4,
                          minHeight: 7,
                          backgroundColor: Color(0xFFE2E8E8),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF20B764),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '2/5',
                          style: TextStyle(
                            color: Color(0xFF153A45),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'bugünkü yemək',
                          style: TextStyle(
                            color: Color(0xFF7B8D93),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF173B46), size: 23),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF344F58),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Row(
        children: [
          _TipIcon(),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dietoloqunla müntəzəm əlaqə saxlayaraq hədəflərinə daha tez çata bilərsən.',
              style: TextStyle(
                color: Color(0xFF41615A),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DISCOVER TAB
  // ============================================================

  Widget _buildDiscoverPage() {
    return ListView(
      key: const ValueKey('discover'),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 125),
      physics: const BouncingScrollPhysics(),
      children: [
        _buildSearch(),

        const SizedBox(height: 18),

        _buildDiscoverBanner(),

        const SizedBox(height: 26),

        _buildSectionHeader(
          title: 'Populyar dietoloqlar',
          trailing: 'Hamısını gör',
          onTap: () {},
        ),

        const SizedBox(height: 12),

        ...List.generate(_dietitians.length, (index) {
          final item = _dietitians[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == _dietitians.length - 1 ? 0 : 11,
            ),
            child: _buildDietitianListCard(item),
          );
        }),
      ],
    );
  }

  Widget _buildSearch() {
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
          onTap: () {},
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

  Widget _buildDiscoverBanner() {
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
                  'Peşəkar dietoloqlarla daha sağlam bir gələcək qur.',
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
                  onPressed: () {},
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

  Widget _buildDietitianListCard(_DietitianMock dietitian) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
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
            _buildAvatar(initials: dietitian.initials, size: 64),

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
                        '${dietitian.rating} (${dietitian.reviews} rəy)',
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
              onPressed: () {},
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

  // ============================================================
  // SHARED
  // ============================================================

  Widget _buildSectionHeader({
    required String title,
    String? badge,
    String? trailing,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF112F38),
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),

        if (badge != null) ...[
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: const BoxDecoration(
              color: Color(0xFFFF5353),
              shape: BoxShape.circle,
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],

        const Spacer(),

        if (trailing != null)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Row(
                children: [
                  Text(
                    trailing,
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

  Widget _buildAvatar({required String initials, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5F0),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
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

class _TipIcon extends StatelessWidget {
  const _TipIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFDDF4E7),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lightbulb_outline_rounded,
        color: Color(0xFF22A760),
        size: 23,
      ),
    );
  }
}

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
