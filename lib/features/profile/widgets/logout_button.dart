import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';
import 'package:kalori_tracker/core/utils/asset_extension.dart';
import 'package:kalori_tracker/core/utils/padding_extension.dart';

import '../../../core/utils/radius_extension.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LogoutButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed ?? () {},
          icon: AppAssets.logout.svg(width: 16, height: 16),
          label: Text(
            'Çıxış',
            style: AppTextStyles.bodyMedium.copyWith(color: Color(0xFFE53935)),
          ),
          style: OutlinedButton.styleFrom(
            padding: 12.py,
            side: const BorderSide(color: Color(0xFFE53935), width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: 16.br),
          ),
        ),
      ),
    );
  }
}
