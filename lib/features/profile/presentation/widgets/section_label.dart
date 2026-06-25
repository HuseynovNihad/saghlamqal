import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 6),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(letterSpacing: 0.5, fontSize: 11),
      ),
    );
  }
}
