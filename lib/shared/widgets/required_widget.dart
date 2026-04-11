import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class RequiredWidget extends StatelessWidget {
  const RequiredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(" *", style: TextStyle(color: AppColors.error));
  }
}
