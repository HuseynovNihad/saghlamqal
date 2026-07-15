import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../../shared/widgets/custom_text_button.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../section_header.dart';

class RegisterSecurityStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onRegister;
  final VoidCallback onBack;
  final VoidCallback onLoginTap;

  const RegisterSecurityStep({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onRegister,
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
          const SectionHeader(icon: AppAssets.security, title: 'Təhlükəsizlik'),
          12.hs,
          CustomTextField(
            label: "Şifrə",
            hintText: "Şifrənizi daxil edin",
            controller: passwordController,
            isPassword: true,
            validator: (value) => AppValidators.combine(value, [
              AppValidators.isNotEmpty,
              AppValidators.password,
            ]),
          ),
          16.hs,
          CustomTextField(
            label: "Şifrəni təsdiqlə",
            hintText: "Şifrənizi təkrar daxil edin",
            controller: confirmPasswordController,
            isPassword: true,
            validator: (value) {
              if (value != passwordController.text) {
                return 'Şifrələr uyğun deyil';
              }
              return AppValidators.combine(value, [AppValidators.isNotEmpty]);
            },
          ),
          24.hs,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    "Geri",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              12.ws,
              Expanded(
                flex: 2,
                child: CustomElevatedButton(
                  text: "Qeydiyyatdan keç",
                  isLoading: isLoading,
                  onPressed: onRegister,
                ),
              ),
            ],
          ),
          16.hs,
          Row(
            children: [
              const Expanded(child: Divider(thickness: 1)),
              Padding(padding: 8.px, child: Text("və ya")),
              const Expanded(child: Divider(thickness: 1)),
            ],
          ),
          8.hs,
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hesabın var? ",
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
