import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_styles.dart';
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
    if (widget.controller == null) return;
    await widget.controller!.setFlashMode(
      _isTorchOn ? FlashMode.off : FlashMode.torch,
    );
    setState(() => _isTorchOn = !_isTorchOn);
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
              onTap: () => Navigator.pop(context),
            ),
            Text(
              'Şəkillə axtar',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            _AppBarButton(
              icon: _isTorchOn
                  ? Icons.flashlight_off_rounded
                  : Icons.flashlight_on_rounded,
              onTap: _toggleTorch,
            ),
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
          color: Colors.black.withOpacity(0.5),
          borderRadius: 16.br,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
