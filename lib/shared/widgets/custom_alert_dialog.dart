import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/l10n/localization_extension.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/radius_extension.dart';
import '../../core/utils/sized_box_extension.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText,
    this.onCancel,
    this.confirmColor,
  });

  final Widget icon;
  final String title;
  final String message;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;

  static Future<void> show(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
    Color? confirmColor,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CustomAlertDialog(
        icon: icon,
        title: title,
        message: message,
        confirmText: confirmText,
        onConfirm: onConfirm,
        cancelText: cancelText,
        onCancel: onCancel,
        confirmColor: confirmColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveCancelText = cancelText ?? context.l10n.commonCancel;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 24.br),
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: 20.p,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,

            16.hs,

            Text(
              title,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.headline,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),

            8.hs,

            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.bodyText.withValues(alpha: 0.6),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            24.hs,

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.bodyText,
                      side: const BorderSide(color: AppColors.borderColor),
                      shape: RoundedRectangleBorder(borderRadius: 12.br),
                      padding: 14.py,
                    ),
                    child: Text(
                      effectiveCancelText,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.bodyText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                12.ws,

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor ?? AppColors.primary,
                      foregroundColor: AppColors.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: 12.br),
                      padding: 14.py,
                    ),
                    child: Text(
                      confirmText,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
