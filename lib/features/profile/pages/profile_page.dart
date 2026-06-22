import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/sized_box_extension.dart';
import '../../../shared/widgets/unauthenticated_view.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../../auth/presentation/bloc/auth_event.dart';
import '../../auth/presentation/bloc/auth_state.dart';
import '../../water_reminder/presentation/widgets/water_reminder_tile.dart';
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
            if (authState is! AuthAuthenticated) {
              return const UnauthenticatedView(
                headerIcon: AppAssets.profile,
                title: 'Profilinə\ndaxil ol',
                subtitle:
                    'Profil məlumatlarını idarə et,\ntənzimləmələrini öz zövqünə uyğunlaşdır.',
                features: [
                  UnauthFeatureItem(
                    icon: AppAssets.edit,
                    label: 'Profil məlumatlarını redaktə et',
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.settings,
                    label: 'Parametrləri idarə et',
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.privacyTip,
                    label: 'Məxfilik və təhlükəsizliyi idarə et',
                  ),
                ],
              );
            }

            final user = authState.user;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInfoCard(
                          name: '${user.firstName} ${user.lastName}',
                          email: user.email,
                          initial: (user.firstName?.isNotEmpty ?? false)
                              ? user.firstName![0].toUpperCase()
                              : 'U',
                        ),
                        const SectionLabel(label: 'Hesab və Parametrlər'),
                        MenuCard(
                          items: [
                            MenuItem(
                              svgAsset: AppAssets.edit,
                              label: 'Profili redaktə et',
                            ),
                            MenuItem(
                              svgAsset: AppAssets.privacyTip,
                              label: 'Məxfilik Siyasəti',
                            ),
                            MenuItem(
                              svgAsset: AppAssets.policy,
                              label: 'İstifadəçi Şərtləri',
                              isLast: true,
                            ),
                          ],
                        ),
                        const SectionLabel(label: 'Bildirişlər'),
                        MenuCard(items: [WaterReminderTile(isLast: true)]),
                        const SectionLabel(label: 'Dəstək'),
                        MenuCard(
                          items: [
                            MenuItem(
                              svgAsset: AppAssets.about,
                              label: 'Haqqımızda',
                              isLast: true,
                            ),
                          ],
                        ),
                        8.hs,
                        MenuCard(
                          items: [
                            MenuItem(
                              svgAsset: AppAssets.logout,
                              label: 'Çıxış',
                              iconColor: const Color(0xFFE53935),
                              bgColor: const Color(0xFFFFF5F5),
                              isLast: true,
                              onTap: () => context.read<AuthBloc>().add(
                                LogoutRequested(),
                              ),
                            ),
                          ],
                        ),
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
