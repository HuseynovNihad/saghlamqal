import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/l10n/localization_extension.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/radius_extension.dart';
import '../../core/utils/sized_box_extension.dart';

class DatePicker {
  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    DateTime? result;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _DatePickerSheet(
        initialDate: initialDate ?? DateTime(2000),
        onConfirm: (date) {
          result = date;
        },
      ),
    );

    return result;
  }
}

class _DatePickerSheet extends StatefulWidget {
  const _DatePickerSheet({required this.initialDate, required this.onConfirm});

  final DateTime initialDate;
  final ValueChanged<DateTime> onConfirm;

  @override
  State<_DatePickerSheet> createState() => _DatePickerSheetState();
}

class _DatePickerSheetState extends State<_DatePickerSheet> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  final int _minYear = 1900;
  final int _maxYear = DateTime.now().year;

  int get _daysInMonth => DateTime(_selectedYear, _selectedMonth + 2, 0).day;

  List<int> get _years =>
      List.generate(_maxYear - _minYear + 1, (index) => _maxYear - index);

  @override
  void initState() {
    super.initState();

    _selectedDay = widget.initialDate.day;
    _selectedMonth = widget.initialDate.month - 1;
    _selectedYear = widget.initialDate.year;

    _dayController = FixedExtentScrollController(initialItem: _selectedDay - 1);

    _monthController = FixedExtentScrollController(initialItem: _selectedMonth);

    final initialYearIndex = _years.indexOf(_selectedYear);

    _yearController = FixedExtentScrollController(
      initialItem: initialYearIndex >= 0 ? initialYearIndex : 0,
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();

    super.dispose();
  }

  String _monthName(int index) {
    final locale = Localizations.localeOf(context).toLanguageTag();

    return DateFormat.MMMM(locale).format(DateTime(2000, index + 1, 1));
  }

  void _onMonthChanged(int index) {
    setState(() {
      _selectedMonth = index;

      if (_selectedDay > _daysInMonth) {
        _selectedDay = _daysInMonth;

        _dayController.jumpToItem(_selectedDay - 1);
      }
    });
  }

  void _onYearChanged(int index) {
    setState(() {
      _selectedYear = _years[index];

      if (_selectedDay > _daysInMonth) {
        _selectedDay = _daysInMonth;

        _dayController.jumpToItem(_selectedDay - 1);
      }
    });
  }

  void _confirm() {
    final date = DateTime(_selectedYear, _selectedMonth + 1, _selectedDay);

    widget.onConfirm(date);

    Navigator.pop(context);
  }

  Widget _buildColumn({
    required FixedExtentScrollController controller,
    required int itemCount,
    required Widget Function(int index) itemBuilder,
    required void Function(int index) onChanged,
    double width = 80,
  }) {
    return SizedBox(
      width: width,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 44,
        perspective: 0.003,
        diameterRatio: 1.6,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index >= itemCount) {
              return null;
            }

            return itemBuilder(index);
          },
          childCount: itemCount,
        ),
      ),
    );
  }

  Widget _buildItem(String text, bool isSelected) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSelected ? 16 : 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.pb,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: 12.pt,
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: 2.br,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    context.l10n.commonCancel,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),

                Flexible(
                  child: Text(
                    context.l10n.datePickerBirthDate,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: _confirm,
                  child: Text(
                    context.l10n.commonConfirm,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          8.hs,

          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 44,
                  margin: 16.px,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: 10.br,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColumn(
                      controller: _dayController,
                      itemCount: _daysInMonth,
                      width: 60,
                      onChanged: (index) {
                        setState(() {
                          _selectedDay = index + 1;
                        });
                      },
                      itemBuilder: (index) {
                        return _buildItem(
                          '${index + 1}',
                          _selectedDay == index + 1,
                        );
                      },
                    ),

                    _buildColumn(
                      controller: _monthController,
                      itemCount: 12,
                      width: 120,
                      onChanged: _onMonthChanged,
                      itemBuilder: (index) {
                        return _buildItem(
                          _monthName(index),
                          _selectedMonth == index,
                        );
                      },
                    ),

                    _buildColumn(
                      controller: _yearController,
                      itemCount: _years.length,
                      width: 80,
                      onChanged: _onYearChanged,
                      itemBuilder: (index) {
                        return _buildItem(
                          '${_years[index]}',
                          _selectedYear == _years[index],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          8.hs,
        ],
      ),
    );
  }
}
