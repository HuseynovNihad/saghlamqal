import 'package:flutter/material.dart';

import '../../../../core/l10n/localization_extension.dart';
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
            label: context.l10n.authFirstNameLabel,
            hintText: context.l10n.authFirstNameHint,
            controller: firstNameController,
            validator: (value) => AppValidators.combine(value, [
              (value) => AppValidators.isNotEmpty(
                value,
                message: context.l10n.validationRequired,
              ),
            ]),
          ),
        ),
        12.ws,
        Expanded(
          child: CustomTextField(
            label: context.l10n.authLastNameLabel,
            hintText: context.l10n.authLastNameHint,
            controller: lastNameController,
            validator: (value) => AppValidators.combine(value, [
              (value) => AppValidators.isNotEmpty(
                value,
                message: context.l10n.validationRequired,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
