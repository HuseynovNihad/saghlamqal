import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../shared/widgets/custom_text_button.dart';
import '../activity_level_field.dart';
import '../register_nav_buttons.dart';
import '../section_header.dart';

class RegisterActivityLevelStep extends StatelessWidget {
  final String? selectedActivityLevel;
  final String? activityLevelError;
  final ValueChanged<String?> onChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onLoginTap;

  const RegisterActivityLevelStep({
    super.key,
    required this.selectedActivityLevel,
    required this.activityLevelError,
    required this.onChanged,
    required this.onNext,
    required this.onBack,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SectionHeader(
          icon: AppAssets.personActive,
          title: 'Aktivlik səviyyəsi',
        ),
        12.hs,
        ActivityLevelField(
          value: selectedActivityLevel,
          errorText: activityLevelError,
          onChanged: onChanged,
        ),
        24.hs,
        RegisterNavButtons(
          showBack: true,
          nextLabel: "Növbəti",
          onNext: onNext,
          onBack: onBack,
        ),
        16.hs,
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(padding: 8.px, child: const Text("və ya")),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),
        8.hs,
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hesabınız yoxdursa? ",
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
              ),
              CustomTextButton(text: "Daxil ol", onPressed: onLoginTap),
            ],
          ),
        ),
      ],
    );
  }
}
