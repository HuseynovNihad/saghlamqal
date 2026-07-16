import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/utils/sized_box_extension.dart';

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

  static const List<String> _months = [
    'Yanvar',
    'Fevral',
    'Mart',
    'Aprel',
    'May',
    'İyun',
    'İyul',
    'Avqust',
    'Sentyabr',
    'Oktyabr',
    'Noyabr',
    'Dekabr',
  ];

  String _formatBirthday(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }

  Future<void> _pickBirthday(BuildContext context) async {
    final picked = await DatePicker.show(
      context,
      initialDate: birthday ?? DateTime(2000, 1, 1),
    );
    if (picked != null) {
      onBirthdayChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final birthdayController = TextEditingController(
      text: birthday != null ? _formatBirthday(birthday!) : '',
    );

    return SectionCard(
      icon: Icons.person_outline_rounded,
      title: 'Şəxsi məlumatlar',
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                label: 'Ad',
                hintText: 'Adınızı daxil edin',
                controller: firstNameController,
                required: true,
              ),
            ),
            12.ws,
            Expanded(
              child: CustomTextField(
                label: 'Soyad',
                hintText: 'Soyadınızı daxil edin',
                controller: lastNameController,
                required: true,
              ),
            ),
          ],
        ),
        12.hs,
        CustomTextField(
          label: 'Email',
          hintText: 'your@email.com',
          controller: emailController,
          enabled: false,
          keyboardType: TextInputType.emailAddress,
        ),
        12.hs,
        PhoneNumberField(
          controller: phoneController,
          label: 'Əlaqə nömrəsi',
          required: true,
        ),
        12.hs,
        CustomTextField(
          label: 'Doğum tarixi',
          hintText: 'Doğum tarixinizi seçin',
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
