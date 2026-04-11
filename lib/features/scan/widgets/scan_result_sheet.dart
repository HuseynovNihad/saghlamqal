import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/padding_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';

class ScanResultSheet extends StatelessWidget {
  final String barcode;
  final VoidCallback onScanAgain;

  const ScanResultSheet({
    super.key,
    required this.barcode,
    required this.onScanAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.p,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          24.hs,
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: 36,
            ),
          ),
          16.hs,
          Text(
            "Barkod oxundu!",
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
          ),
          8.hs,
          Text(
            barcode,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
          ),
          24.hs,
          // TODO: Open Food Facts API-dən məhsul məlumatı gələcək
          Container(
            width: double.infinity,
            padding: 16.p,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: 16.br,
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Center(
              child: Text(
                "Məhsul məlumatı yüklənir...",
                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
              ),
            ),
          ),
          24.hs,
          GestureDetector(
            onTap: onScanAgain,
            child: Container(
              width: double.infinity,
              padding: 16.py,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: 16.br,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  8.hw,
                  Text(
                    "Yenidən scan et",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.hs,
        ],
      ),
    );
  }
}
