import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/unauthenticated_view.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../auth/presentation/bloc/auth_state.dart';
import '../../water_reminder/presentation/widgets/water_reminder_tile.dart';
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
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              return const UnauthenticatedView(
                headerIcon: Icons.person_outline_rounded,
                title: 'Profilinə\ndaxil ol',
                subtitle:
                    'Profil məlumatlarını idarə et,\ntənzimləmələrini öz zövqünə uyğunlaşdır.',
                features: [
                  UnauthFeatureItem(
                    icon: Icons.history_rounded,
                    label: 'Profil məlumatlarını redaktə et',
                  ),
                  UnauthFeatureItem(
                    icon: Icons.settings_outlined,
                    label: 'Parametrləri idarə et',
                  ),
                  UnauthFeatureItem(
                    icon: Icons.notifications_outlined,
                    label: 'Məxfilik və təhlükəsizliyi idarə et',
                  ),
                ],
              );
            }
            return Column(
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
                              label: 'Məxfilik və təhlükəsizlik',
                            ),
                            MenuItem(
                              icon: Icons.tune_rounded,
                              iconColor: AppColors.primary,
                              label: 'Tənzimləmələr',
                              isLast: true,
                            ),
                          ],
                        ),
                        const SectionLabel(label: 'Bildirişlər'),
                        MenuCard(
                          items: [
                            WaterReminderTile(isLast: true),
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
            );
          },
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