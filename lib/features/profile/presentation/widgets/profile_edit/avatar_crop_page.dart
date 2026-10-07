import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/l10n/localization_extension.dart';

class AvatarCropPage extends StatefulWidget {
  const AvatarCropPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<AvatarCropPage> createState() => _AvatarCropPageState();
}

class _AvatarCropPageState extends State<AvatarCropPage> {
  final CropController _cropController = CropController();

  Uint8List? _imageBytes;

  bool _isLoading = true;
  bool _isCropping = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final file = File(widget.imagePath);

      final bytes = await file.readAsBytes();

      if (!mounted) {
        return;
      }

      setState(() {
        _imageBytes = bytes;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _cropImage() {
    if (_isCropping || _imageBytes == null) {
      return;
    }

    setState(() {
      _isCropping = true;
    });

    _cropController.crop();
  }

  void _handleCropResult(CropResult result) {
    switch (result) {
      case CropSuccess(:final croppedImage):
        if (!mounted) {
          return;
        }

        Navigator.of(context).pop<Uint8List>(croppedImage);

      case CropFailure():
        if (!mounted) {
          return;
        }

        setState(() {
          _isCropping = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.profileAvatarCropError)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(child: _buildContent()),

            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: _isCropping
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 27,
              ),
            ),

            Expanded(
              child: Text(
                context.l10n.profileAvatarCropTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_hasError || _imageBytes == null) {
      return _buildError();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cropSize = constraints.maxWidth * 0.78;

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Crop(
                image: _imageBytes!,
                controller: _cropController,
                aspectRatio: 1,
                baseColor: Colors.black,
                maskColor: Colors.transparent,
                interactive: true,
                fixCropRect: true,
                withCircleUi: false,
                onCropped: _handleCropResult,
              ),
            ),

            Center(
              child: IgnorePointer(
                child: Container(
                  width: cropSize,
                  height: cropSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                  ),
                ),
              ),
            ),

            Positioned(
              top: (constraints.maxHeight - cropSize) / 2 - 44,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white.withValues(alpha: 0.75),
                      size: 16,
                    ),

                    const SizedBox(width: 6),

                    Flexible(
                      child: Text(
                        context.l10n.profileAvatarCropArea,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.80),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.broken_image_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              context.l10n.profileAvatarImageOpenError,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              context.l10n.profileAvatarImageOpenErrorDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pinch_rounded,
                size: 18,
                color: Colors.white.withValues(alpha: 0.65),
              ),

              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  context.l10n.profileAvatarCropMoveHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isLoading || _hasError || _isCropping
                  ? null
                  : _cropImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withValues(
                  alpha: 0.5,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: _isCropping
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_rounded, size: 21),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.profileAvatarCropDone,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
