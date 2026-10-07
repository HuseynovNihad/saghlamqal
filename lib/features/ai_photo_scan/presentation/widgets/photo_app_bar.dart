import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/l10n/localization_extension.dart';
import '../../../../../core/utils/asset_extension.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/radius_extension.dart';

class PhotoAppBar extends StatefulWidget {
  final CameraController? controller;

  const PhotoAppBar({super.key, this.controller});

  @override
  State<PhotoAppBar> createState() => _PhotoAppBarState();
}

class _PhotoAppBarState extends State<PhotoAppBar> {
  bool _isTorchOn = false;

  Future<void> _toggleTorch() async {
    final controller = widget.controller;

    if (controller == null) return;

    await controller.setFlashMode(_isTorchOn ? FlashMode.off : FlashMode.torch);

    if (!mounted) return;

    setState(() {
      _isTorchOn = !_isTorchOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AppBarButton(
              icon: Icons.arrow_back_rounded,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  context.l10n.photoScanTitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            _FlashButton(isTorchOn: _isTorchOn, onTap: _toggleTorch),
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 12.p,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: 16.br,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _FlashButton extends StatelessWidget {
  final bool isTorchOn;
  final VoidCallback onTap;

  const _FlashButton({required this.isTorchOn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: 12.p,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: 16.br,
        ),
        child: isTorchOn
            ? AppAssets.flashOff.svg(width: 20, height: 20, color: Colors.white)
            : AppAssets.flashOn.svg(width: 20, height: 20, color: Colors.white),
      ),
    );
  }
}
