import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/date_picker.dart';

class BirthdayField extends StatelessWidget {
  final DateTime? selectedBirthday;
  final int? calculatedAge;
  final String? errorText;
  final ValueChanged<DateTime> onChanged;

  const BirthdayField({
    super.key,
    required this.selectedBirthday,
    required this.calculatedAge,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await DatePicker.show(
          context,
          initialDate: selectedBirthday,
        );
        if (date != null) onChanged(date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Doğum tarixi", style: AppTextStyles.fieldLabel),
          8.hs,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null
                    ? AppColors.error
                    : AppColors.borderColor,
              ),
              borderRadius: 16.br,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                8.ws,
                Expanded(
                  child: Text(
                    selectedBirthday != null
                        ? "${selectedBirthday!.day.toString().padLeft(2, '0')}."
                              "${selectedBirthday!.month.toString().padLeft(2, '0')}."
                              "${selectedBirthday!.year}  ($calculatedAge yaş)"
                        : "Doğum tarixini seçin",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: selectedBirthday != null
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
          if (errorText != null) ...[
            4.hs,
            Text(errorText!, style: AppTextStyles.errorText),
          ],
        ],
      ),
    );
  }
}
