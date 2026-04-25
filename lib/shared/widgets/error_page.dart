import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../core/enums/error_type.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/radius_extension.dart';

class ErrorPage extends StatelessWidget {
  final ErrorType type;
  final String? message;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  const ErrorPage({
    super.key,
    this.type = ErrorType.unknown,
    this.message,
    this.onRetry,
    this.onBack,
  });

  _ErrorContent get _content => switch (type) {
    ErrorType.notFound => const _ErrorContent(
      emoji: '🔍',
      title: 'Səhifə tapılmadı',
      subtitle: 'Axtardığınız səhifə mövcud deyil və ya silinib.',
    ),
    ErrorType.network => const _ErrorContent(
      emoji: '📡',
      title: 'Bağlantı xətası',
      subtitle: 'İnternet bağlantınızı yoxlayın və yenidən cəhd edin.',
    ),
    ErrorType.server => const _ErrorContent(
      emoji: '🛠️',
      title: 'Server xətası',
      subtitle: 'Serverdə problem baş verdi. Bir az sonra yenidən cəhd edin.',
    ),
    ErrorType.unknown => const _ErrorContent(
      emoji: '⚠️',
      title: 'Xəta baş verdi',
      subtitle: 'Gözlənilməz bir xəta baş verdi. Yenidən cəhd edin.',
    ),
  };

  @override
  Widget build(BuildContext context) {
    final content = _content;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: 24.p,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    content.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
              32.hs,

              // Başlıq
              Text(
                content.title,
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              12.hs,

              // Açıqlama
              Text(
                message ?? content.subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Düymələr
              Column(
                children: [
                  if (onRetry != null)
                    _ErrorButton(
                      label: "Yenidən cəhd et",
                      icon: Icons.refresh_rounded,
                      onTap: onRetry!,
                      isPrimary: true,
                    ),
                  if (onRetry != null && onBack != null) 12.hs,
                  if (onBack != null)
                    _ErrorButton(
                      label: "Geri qayıt",
                      icon: Icons.arrow_back_rounded,
                      onTap: onBack!,
                      isPrimary: false,
                    ),
                ],
              ),
              24.hs,
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorContent {
  final String emoji;
  final String title;
  final String subtitle;

  const _ErrorContent({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });
}

class _ErrorButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ErrorButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: 16.py,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.white,
          borderRadius: 14.br,
          border: isPrimary ? null : Border.all(color: AppColors.borderColor),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isPrimary ? Colors.white : AppColors.primary,
            ),
            8.ws,
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
