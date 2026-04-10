import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/utils/asset_extension.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppAssets.logo.png(width: 240, height: 240)),
    );
  }
}
