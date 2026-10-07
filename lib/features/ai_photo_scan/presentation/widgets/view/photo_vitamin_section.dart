import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/l10n/localization_extension.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoVitaminSection extends StatelessWidget {
  final Map<String, double?> vitamins;

  const PhotoVitaminSection({super.key, required this.vitamins});

  @override
  Widget build(BuildContext context) {
    final entries = vitamins.entries
        .where((entry) => entry.value != null)
        .toList();

    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _VitaminItem(name: entry.key, amount: entry.value!),
            ),
          )
          .toList(),
    );
  }
}

class _VitaminItem extends StatelessWidget {
  final String name;
  final double amount;

  const _VitaminItem({required this.name, required this.amount});

  String get _iconText {
    final match = RegExp(r'([A-Za-z]+\d*)$').firstMatch(name.trim());

    if (match != null) {
      return match.group(0)!.toUpperCase();
    }

    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 12.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 12.br,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: 10.br,
            ),
            child: Text(
              _iconText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),

          12.ws,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  '${amount.toStringAsFixed(1)} '
                  '${context.l10n.unitMilligram}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
