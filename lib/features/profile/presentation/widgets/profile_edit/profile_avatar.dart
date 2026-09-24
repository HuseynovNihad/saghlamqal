import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.initial,
    this.imageUrl,
    this.localImagePath,
    required this.onEditTap,
    this.isLoading = false,
    this.size = 128,
  });

  final String initial;
  final String? imageUrl;
  final String? localImagePath;
  final VoidCallback onEditTap;
  final bool isLoading;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasLocalImage =
        localImagePath != null && localImagePath!.trim().isNotEmpty;

    final hasNetworkImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: isLoading ? null : onEditTap,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.12),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildAvatarContent(
                    hasLocalImage: hasLocalImage,
                    hasNetworkImage: hasNetworkImage,
                  ),

                  if (isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.35),
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 2,
            bottom: 2,
            child: Material(
              color: AppColors.primary,
              shape: const CircleBorder(),
              elevation: 3,
              child: InkWell(
                onTap: isLoading ? null : onEditTap,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 38,
                  height: 38,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent({
    required bool hasLocalImage,
    required bool hasNetworkImage,
  }) {
    if (hasLocalImage) {
      return Image.file(
        File(localImagePath!),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _buildInitial();
        },
      );
    }

    if (hasNetworkImage) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _buildInitial();
        },
      );
    }

    return _buildInitial();
  }

  Widget _buildInitial() {
    return Center(
      child: Text(
        initial.toUpperCase(),
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
