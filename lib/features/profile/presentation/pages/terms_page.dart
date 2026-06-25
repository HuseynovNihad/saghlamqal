import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/enums/terms_type.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/entities/terms_section_entity.dart';
import '../bloc/profile_bloc.dart';

class TermsPage extends StatelessWidget {
  final TermsType type;

  const TermsPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileBloc>()
        ..add(
          type == TermsType.termsOfService
              ? const ProfileTermsOfServiceRequested()
              : const ProfilePrivacyPolicyRequested(),
        ),
      child: _TermsView(type: type),
    );
  }
}

class _TermsView extends StatelessWidget {
  final TermsType type;

  const _TermsView({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: const Color(0xFF1A1A1A),
        ),
        title: Text(
          type == TermsType.termsOfService
              ? 'İstifadəçi Şərtləri'
              : 'Məxfilik Siyasəti',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: Color(0xFFBDBDBD),
                  ),
                  16.hs,
                  Text(
                    'Məlumat yüklənəmədi',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileTermsLoaded) {
            return _TermsContent(terms: state.terms);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TermsContent extends StatelessWidget {
  final TermsEntity terms;

  const _TermsContent({required this.terms});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        ...terms.content.map((section) => _SectionCard(section: section)),
        32.hs,
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final TermsSectionEntity section;

  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 12.pb,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.br,
          border: Border.all(color: AppColors.borderColor, width: 0.8),
        ),
        child: Padding(
          padding: 16.p,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.section,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              10.hs,
              Text(
                section.text,
                style: AppTextStyles.bodySmall.copyWith(
                  color: const Color(0xFF666666),
                  height: 1.55,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
