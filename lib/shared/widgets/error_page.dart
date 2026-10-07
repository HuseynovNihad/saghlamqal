import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/error_type.dart';
import '../../core/l10n/localization_extension.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/radius_extension.dart';
import '../../core/utils/sized_box_extension.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.type = ErrorType.unknown,
    this.message,
    this.onRetry,
    this.onBack,
  });

  final ErrorType type;
  final String? message;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  _ErrorContent _content(BuildContext context) => switch (type) {
    ErrorType.notFound => _ErrorContent(
      emoji: '🔍',
      title: context.l10n.errorPageNotFoundTitle,
      subtitle: context.l10n.errorPageNotFoundSubtitle,
    ),
    ErrorType.network => _ErrorContent(
      emoji: '📡',
      title: context.l10n.errorPageNetworkTitle,
      subtitle: context.l10n.errorPageNetworkSubtitle,
    ),
    ErrorType.server => _ErrorContent(
      emoji: '🛠️',
      title: context.l10n.errorPageServerTitle,
      subtitle: context.l10n.errorPageServerSubtitle,
    ),
    ErrorType.unknown => _ErrorContent(
      emoji: '⚠️',
      title: context.l10n.errorPageUnknownTitle,
      subtitle: context.l10n.errorPageUnknownSubtitle,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final content = _content(context);

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
                      color: Colors.black.withValues(alpha: 0.06),
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

              Text(
                content.title,
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),

              12.hs,

              Text(
                message ?? content.subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Column(
                children: [
                  if (onRetry != null)
                    _ErrorButton(
                      label: context.l10n.commonRetry,
                      icon: Icons.refresh_rounded,
                      onTap: onRetry!,
                      isPrimary: true,
                    ),

                  if (onRetry != null && onBack != null) 12.hs,

                  if (onBack != null)
                    _ErrorButton(
                      label: context.l10n.commonGoBack,
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
  const _ErrorContent({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  final String emoji;
  final String title;
  final String subtitle;
}

class _ErrorButton extends StatelessWidget {
  const _ErrorButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

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
                    color: AppColors.primary.withValues(alpha: 0.3),
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

            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isPrimary ? Colors.white : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
