import 'package:flutter/material.dart';

import '../../../../../core/l10n/localization_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../shared/widgets/date_picker.dart';
import '../../../../auth/presentation/widgets/phone_number_field.dart';
import 'section_card.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.birthday,
    required this.onBirthdayChanged,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  final DateTime? birthday;

  final ValueChanged<DateTime> onBirthdayChanged;

  Future<void> _pickBirthday(BuildContext context) async {
    final picked = await DatePicker.show(
      context,
      initialDate: birthday ?? DateTime(2000, 1, 1),
    );

    if (picked != null) {
      onBirthdayChanged(picked);
    }
  }

  String _formatBirthday(BuildContext context, DateTime date) {
    return MaterialLocalizations.of(context).formatMediumDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final birthdayController = TextEditingController(
      text: birthday != null ? _formatBirthday(context, birthday!) : '',
    );

    return SectionCard(
      icon: Icons.person_outline_rounded,
      title: context.l10n.profileEditPersonalInfo,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                label: context.l10n.profileEditFirstName,
                hintText: context.l10n.profileEditFirstNameHint,
                controller: firstNameController,
                required: true,
              ),
            ),
            12.ws,
            Expanded(
              child: CustomTextField(
                label: context.l10n.profileEditLastName,
                hintText: context.l10n.profileEditLastNameHint,
                controller: lastNameController,
                required: true,
              ),
            ),
          ],
        ),

        12.hs,

        CustomTextField(
          label: context.l10n.profileEditEmail,
          hintText: 'your@email.com',
          controller: emailController,
          enabled: false,
          keyboardType: TextInputType.emailAddress,
        ),

        12.hs,

        PhoneNumberField(
          controller: phoneController,
          label: context.l10n.profileEditPhone,
          required: true,
        ),

        12.hs,

        CustomTextField(
          label: context.l10n.profileEditBirthday,
          hintText: context.l10n.profileEditBirthdayHint,
          controller: birthdayController,
          readOnly: true,
          onTap: () => _pickBirthday(context),
          suffixIcon: const Icon(
            Icons.calendar_today_rounded,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
