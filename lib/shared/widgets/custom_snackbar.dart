import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/radius_extension.dart';
import '../../core/utils/sized_box_extension.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.success,
  }) {
    final color = _getColor(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: 12.br),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            10.hw,
            Expanded(child: Text(message, style: AppTextStyles.bodyMedium)),
          ],
        ),
      ),
    );
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}

enum SnackBarType { success, error, warning, info }
