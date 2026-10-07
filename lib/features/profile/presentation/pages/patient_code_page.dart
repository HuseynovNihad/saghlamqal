import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/l10n/localization_extension.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_appbar.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../bloc/profile_bloc.dart';

class PatientCodePage extends StatelessWidget {
  const PatientCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()..add(const ProfileRequested()),
      child: const _PatientCodeView(),
    );
  }
}

class _PatientCodeView extends StatelessWidget {
  const _PatientCodeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.patientCodeTitle),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial || state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              );
            }

            if (state is ProfileError) {
              return _ErrorState(
                onRetry: () {
                  context.read<ProfileBloc>().add(const ProfileRequested());
                },
              );
            }

            if (state is ProfileLoaded) {
              final patientCode = state.user.patientCode?.trim();

              if (patientCode == null || patientCode.isEmpty) {
                return const _EmptyCodeState();
              }

              return _PatientCodeContent(patientCode: patientCode);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PatientCodeContent extends StatelessWidget {
  const _PatientCodeContent({required this.patientCode});

  final String patientCode;

  Future<void> _copyCode(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: patientCode));

    if (!context.mounted) {
      return;
    }

    CustomSnackBar.show(
      context,
      message: context.l10n.patientCodeCopied,
      type: SnackBarType.success,
      position: SnackBarPosition.top,
    );
  }

  Future<void> _shareCode(BuildContext context) async {
    await Share.share(
      context.l10n.patientCodeShareText(patientCode),
      subject: context.l10n.patientCodeShareSubject,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _HeaderSection(),

          28.hs,

          _CodeCard(patientCode: patientCode, onCopy: () => _copyCode(context)),

          18.hs,

          _ActionButton(
            icon: Icons.copy_rounded,
            label: context.l10n.patientCodeCopy,
            isPrimary: true,
            onTap: () => _copyCode(context),
          ),

          12.hs,

          _ActionButton(
            icon: Icons.ios_share_rounded,
            label: context.l10n.patientCodeShare,
            onTap: () => _shareCode(context),
          ),

          24.hs,

          const _InfoCard(),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: AppAssets.patientCode.svg(
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),

        12.hs,

        Text(
          context.l10n.patientCodeHeaderTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.h3.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF202124),
          ),
        ),

        10.hs,

        Text(
          context.l10n.patientCodeHeaderDescription,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFF777B84),
            fontSize: 14,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.patientCode, required this.onCopy});

  final String patientCode;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8E9ED), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.patientCodeLabel,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF9A9EA7),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                8.hs,

                SelectableText(
                  patientCode,
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.2,
                    color: const Color(0xFF202124),
                  ),
                ),
              ],
            ),
          ),

          Material(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onCopy,
              borderRadius: BorderRadius.circular(14),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.copy_rounded,
                  size: 21,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Material(
        color: isPrimary ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isPrimary
                  ? null
                  : Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isPrimary ? Colors.white : const Color(0xFF2A2D34),
                ),

                const SizedBox(width: 10),

                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isPrimary ? Colors.white : const Color(0xFF2A2D34),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF5274C8),
            size: 20,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              context.l10n.patientCodePrivacyNote,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF5D6781),
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCodeState extends StatelessWidget {
  const _EmptyCodeState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F1F3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.badge_outlined,
                size: 32,
                color: Color(0xFF9A9EA7),
              ),
            ),

            18.hs,

            Text(
              context.l10n.patientCodeNotFoundTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.h3.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            8.hs,

            Text(
              context.l10n.patientCodeNotFoundDescription,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF7A7E87),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 46,
              color: Color(0xFFB0B3BA),
            ),

            16.hs,

            Text(
              context.l10n.profileLoadFailed,
              textAlign: TextAlign.center,
              style: AppTextStyles.h3.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            8.hs,

            Text(
              context.l10n.profileLoadErrorDescription,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF7A7E87),
              ),
            ),

            18.hs,

            TextButton(
              onPressed: onRetry,
              child: Text(context.l10n.profileRetry),
            ),
          ],
        ),
      ),
    );
  }
}
