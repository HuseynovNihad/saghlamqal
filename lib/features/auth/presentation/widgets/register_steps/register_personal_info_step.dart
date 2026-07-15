import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../shared/widgets/custom_text_button.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../birthday_field.dart';
import '../name_field.dart';
import '../phone_number_field.dart';
import '../register_nav_buttons.dart';
import '../section_header.dart';

class RegisterPersonalInfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final DateTime? selectedBirthday;
  final int? calculatedAge;
  final String? birthdayError;
  final ValueChanged<DateTime?> onBirthdayChanged;
  final VoidCallback onNext;
  final VoidCallback onLoginTap;

  const RegisterPersonalInfoStep({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.phoneNumberController,
    required this.firstNameController,
    required this.lastNameController,
    required this.selectedBirthday,
    required this.calculatedAge,
    required this.birthdayError,
    required this.onBirthdayChanged,
    required this.onNext,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionHeader(icon: AppAssets.profile, title: 'Şəxsi məlumat'),
          12.hs,
          CustomTextField(
            label: "Email",
            hintText: "Emailinizi daxil edin",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidators.combine(value, [
              AppValidators.isNotEmpty,
              AppValidators.email,
            ]),
          ),
          16.hs,
          PhoneNumberField(controller: phoneNumberController),
          16.hs,
          NameField(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
          ),
          16.hs,
          BirthdayField(
            selectedBirthday: selectedBirthday,
            calculatedAge: calculatedAge,
            errorText: birthdayError,
            onChanged: onBirthdayChanged,
          ),
          24.hs,
          RegisterNavButtons(
            showBack: false,
            nextLabel: "Növbəti",
            onNext: onNext,
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
