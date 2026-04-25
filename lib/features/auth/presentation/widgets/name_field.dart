import 'package:flutter/material.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class NameField extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const NameField({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "Ad",
            hintText: "Adınızı daxil edin",
            controller: firstNameController,
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
        12.ws,
        Expanded(
          child: CustomTextField(
            label: "Soyad",
            hintText: "Soyadınızı daxil edin",
            controller: lastNameController,
            validator: (value) =>
                AppValidators.combine(value, [AppValidators.isNotEmpty]),
          ),
        ),
      ],
    );
  }
}
