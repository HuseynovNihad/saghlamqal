import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../shared/widgets/controller_stepper_field.dart';
import '../../../../../shared/widgets/custom_text_button.dart';
import '../gender_field.dart';
import '../register_nav_buttons.dart';
import '../section_header.dart';
import '../weight_height_field.dart';

class RegisterPhysicalInfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController targetWeightController;
  final String? selectedGender;
  final String? genderError;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onLoginTap;

  const RegisterPhysicalInfoStep({
    super.key,
    required this.formKey,
    required this.weightController,
    required this.heightController,
    required this.targetWeightController,
    required this.selectedGender,
    required this.genderError,
    required this.onGenderChanged,
    required this.onNext,
    required this.onBack,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionHeader(icon: AppAssets.gym, title: 'Fiziki məlumat'),
          12.hs,
          WeightHeightField(
            weightController: weightController,
            heightController: heightController,
          ),
          16.hs,
          ControllerStepperField(
            controller: targetWeightController,
            label: "Hədəf çəki",
            unit: "kq",
            min: 20,
            max: 300,
            step: 0.1,
            majorEvery: 10,
            decimals: 1,
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
          16.hs,
          GenderField(
            value: selectedGender,
            errorText: genderError,
            onChanged: onGenderChanged,
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
      ),
    );
  }
}
