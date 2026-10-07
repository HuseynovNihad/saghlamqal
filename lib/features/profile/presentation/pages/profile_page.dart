import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/animated_refresh_indicator.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';
import '../../../../shared/widgets/language_selection_sheet.dart';
import '../../../../shared/widgets/unauthenticated_view.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../dietitian_invites/presentation/bloc/dietitian_invites_bloc.dart';
import '../../../water_reminder/presentation/widgets/water_reminder_tile.dart';
import '../widgets/menu_card.dart';
import '../widgets/menu_item.dart';
import '../widgets/section_label.dart';
import '../widgets/user_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<DietitianInvitesBloc>(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future<void> _refreshInvites(BuildContext context) async {
    final bloc = context.read<DietitianInvitesBloc>();

    final refreshFuture = bloc.stream.firstWhere(
      (state) =>
          state is DietitianInvitesLoaded || state is DietitianInvitesError,
    );

    bloc.add(const DietitianInvitesRequested());

    await refreshFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is! AuthAuthenticated) {
              return UnauthenticatedView(
                headerIcon: AppAssets.profile,
                title: context.l10n.profileGuestTitle,
                subtitle: context.l10n.profileGuestSubtitle,
                features: [
                  UnauthFeatureItem(
                    icon: AppAssets.edit,
                    label: context.l10n.profileGuestFeatureEdit,
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.settings,
                    label: context.l10n.profileGuestFeatureSettings,
                  ),
                  UnauthFeatureItem(
                    icon: AppAssets.privacyTip,
                    label: context.l10n.profileGuestFeaturePrivacy,
                  ),
                ],
              );
            }

            final user = authState.user;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),

                Expanded(
                  child: AnimatedRefreshIndicator(
                    onRefresh: () => _refreshInvites(context),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInfoCard(
                            name:
                                '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                    .trim(),
                            email: user.email,
                            initial: (user.firstName?.isNotEmpty ?? false)
                                ? user.firstName![0].toUpperCase()
                                : user.email.isNotEmpty
                                ? user.email[0].toUpperCase()
                                : 'U',
                            imageUrl: user.avatar,
                          ),

                          SectionLabel(
                            label: context.l10n.profileSectionAccountSettings,
                          ),

                          MenuCard(
                            items: [
                              MenuItem(
                                svgAsset: AppAssets.edit,
                                label: context.l10n.profileEditMenu,
                                onTap: () {
                                  context.push(AppRoutes.profileEdit);
                                },
                              ),

                              MenuItem(
                                svgAsset: AppAssets.patientCodeMenu,
                                label: context.l10n.profilePatientCodeMenu,
                                onTap: () {
                                  context.push(AppRoutes.patientCode);
                                },
                              ),

                              MenuItem(
                                svgAsset: AppAssets.settings,
                                label: context.l10n.languageTitle,
                                onTap: () {
                                  showLanguageSelectionSheet(context);
                                },
                              ),

                              MenuItem(
                                svgAsset: AppAssets.privacyTip,
                                label: context.l10n.privacyPolicyTitle,
                                onTap: () {
                                  context.push(AppRoutes.privacyPolicy);
                                },
                              ),

                              MenuItem(
                                svgAsset: AppAssets.policy,
                                label: context.l10n.termsOfServiceTitle,
                                onTap: () {
                                  context.push(AppRoutes.termsOfService);
                                },
                                isLast: true,
                              ),
                            ],
                          ),

                          SectionLabel(
                            label: context.l10n.profileSectionNotifications,
                          ),

                          const MenuCard(
                            items: [WaterReminderTile(isLast: true)],
                          ),

                          SectionLabel(
                            label: context.l10n.profileSectionSupport,
                          ),

                          MenuCard(
                            items: [
                              MenuItem(
                                svgAsset: AppAssets.about,
                                label: context.l10n.aboutUsTitle,
                                isLast: true,
                                onTap: () {
                                  context.push(AppRoutes.aboutUs);
                                },
                              ),
                            ],
                          ),

                          8.hs,

                          MenuCard(
                            items: [
                              MenuItem(
                                svgAsset: AppAssets.logout,
                                label: context.l10n.profileLogout,
                                iconColor: const Color(0xFFE53935),
                                bgColor: const Color(0xFFFFF5F5),
                                isLast: true,
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                              ),
                            ],
                          ),

                          8.hs,

                          MenuCard(
                            items: [
                              MenuItem(
                                svgAsset: AppAssets.deleteAccount,
                                label: context.l10n.profileDeleteAccount,
                                iconColor: const Color(0xFFE53935),
                                bgColor: const Color(0xFFFFF5F5),
                                isLast: true,
                                onTap: () {
                                  _showDeleteAccountDialog(context);
                                },
                              ),
                            ],
                          ),

                          8.hs,
                        ],
                      ),
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

  void _showLogoutDialog(BuildContext context) {
    CustomAlertDialog.show(
      context,
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppAssets.logout.svg(
            color: AppColors.error,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: context.l10n.profileLogoutTitle,
      message: context.l10n.profileLogoutMessage,
      confirmText: context.l10n.profileLogout,
      confirmColor: AppColors.error,
      onConfirm: () {
        context.read<AuthBloc>().add(LogoutRequested());
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    CustomAlertDialog.show(
      context,
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppAssets.deleteAccount.svg(
            color: AppColors.error,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: context.l10n.profileDeleteAccount,
      message: context.l10n.profileDeleteAccountMessage,
      confirmText: context.l10n.profileDeleteConfirm,
      confirmColor: AppColors.error,
      onConfirm: () {
        context.read<AuthBloc>().add(const DeleteAccountRequested());
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        context.l10n.profileTitle,
        style: AppTextStyles.h1.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
