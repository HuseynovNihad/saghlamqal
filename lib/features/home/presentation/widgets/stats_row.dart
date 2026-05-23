import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class StatsRow extends StatelessWidget {
  final List<StatCell> cells;

  const StatsRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
        borderRadius: 16.br,
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(cells.length * 2 - 1, (i) {
            if (i.isOdd) {
              return VerticalDivider(
                width: 0.8,
                thickness: 0.8,
                color: Colors.grey.shade200,
              );
            }
            return Expanded(child: cells[i ~/ 2]);
          }),
        ),
      ),
    );
  }
}

class StatCell extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const StatCell({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10)),
          4.hs,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: value, style: AppTextStyles.bodyMedium),
                TextSpan(
                  text: ' $unit',
                  style: AppTextStyles.caption.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
