import 'package:flutter/material.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoErrorView extends StatelessWidget {
  final String message;

  const PhotoErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 32,
          ),
        ),
        16.hs,
        Text(
          'Xəta baş verdi',
          style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
        ),
        8.hs,
        Text(
          message,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
