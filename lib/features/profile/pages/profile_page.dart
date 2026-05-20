import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/logout_button.dart';
import '../widgets/menu_card.dart';
import '../widgets/menu_item.dart';
import '../widgets/section_label.dart';
import '../widgets/user_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UserInfoCard(
                      name: 'Nihad Huseynov',
                      email: 'nihadhuseynov@example.com',
                      initial: 'N',
                    ),
                    const SectionLabel(label: 'Hesab və Parametrlər'),
                    MenuCard(
                      items: [
                        MenuItem(
                          icon: Icons.edit_outlined,
                          iconColor: AppColors.primary,
                          label: 'Profili redaktə et',
                        ),
                        MenuItem(
                          icon: Icons.shield_outlined,
                          iconColor: AppColors.primary,
                          label: 'Maxfilik və təhlükəsizlik',
                        ),
                        MenuItem(
                          icon: Icons.tune_rounded,
                          iconColor: AppColors.primary,
                          label: 'Tənzimləmələr',
                          isLast: true,
                        ),
                      ],
                    ),
                    const SectionLabel(label: 'Dəstək'),
                    MenuCard(
                      items: [
                        MenuItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: AppColors.primary,
                          label: 'Haqqımızda',
                          isLast: true,
                        ),
                      ],
                    ),
                    const LogoutButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        'Profil',
        style: AppTextStyles.h1.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
