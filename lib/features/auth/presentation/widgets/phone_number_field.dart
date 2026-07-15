import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../core/utils/app_validators.dart';

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digitsOnly.length > 9
        ? digitsOnly.substring(0, 9)
        : digitsOnly;

    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      buffer.write(limited[i]);
      if (i == 1 || i == 4 || i == 6) {
        if (i != limited.length - 1) buffer.write(' ');
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool required;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.label = "Telefon nömrəsi",
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      hintText: "50 123 45 67",
      controller: controller,
      keyboardType: TextInputType.phone,
      required: required,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 4),
        child: Center(
          widthFactor: 1,
          child: Text("+994", style: AppTextStyles.bodyMedium),
        ),
      ),
      inputFormatters: [_PhoneNumberFormatter()],
      validator: (value) => AppValidators.phone(value?.replaceAll(' ', '')),
    );
  }
}
