import 'package:flutter/material.dart';

import '../../../../core/utils/padding_extension.dart';

class PhotoCaptureButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const PhotoCaptureButton({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isLoading ? Colors.white38 : Colors.white,
            border: Border.all(color: Colors.white38, width: 4),
          ),
          child: isLoading
              ? Padding(
                  padding: 20.p,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black54,
                  ),
                )
              : const Icon(Icons.camera_alt, size: 32, color: Colors.black),
        ),
      ),
    );
  }
}
