import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class AvatarSourceBottomSheet extends StatelessWidget {
  const AvatarSourceBottomSheet({
    super.key,
    required this.hasAvatar,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onDeleteTap,
  });

  final bool hasAvatar;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onDeleteTap;

  static Future<void> show({
    required BuildContext context,
    required bool hasAvatar,
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
    required VoidCallback onDeleteTap,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.30),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return AvatarSourceBottomSheet(
          hasAvatar: hasAvatar,
          onCameraTap: onCameraTap,
          onGalleryTap: onGalleryTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),

          const SizedBox(height: 22),

          _buildHeader(context),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: _AvatarSourceOption(
                  icon: Icons.camera_alt_rounded,
                  title: 'Kamera',
                  subtitle: 'Yeni şəkil çək',
                  onTap: () {
                    Navigator.of(context).pop();
                    onCameraTap();
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _AvatarSourceOption(
                  icon: Icons.photo_library_rounded,
                  title: 'Qalereya',
                  subtitle: 'Şəkillərdən seç',
                  onTap: () {
                    Navigator.of(context).pop();
                    onGalleryTap();
                  },
                ),
              ),
            ],
          ),

          if (hasAvatar) ...[
            const SizedBox(height: 18),

            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F3F1)),

            const SizedBox(height: 14),

            _DeleteAvatarButton(
              onTap: () {
                Navigator.of(context).pop();
                onDeleteTap();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFDDE4E1),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 24,
          ),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profil şəklini dəyiş',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF17231E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Yeni şəkil çək və ya qalereyadan seç',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7A8983),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        Material(
          color: const Color(0xFFF4F7F5),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 38,
              height: 38,
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: Color(0xFF65736D),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AvatarSourceOption extends StatelessWidget {
  const _AvatarSourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FAF8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE9EFEC), width: 1),
          ),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 25),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF17231E),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF819089),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteAvatarButton extends StatelessWidget {
  const _DeleteAvatarButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6F6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE8E8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFFE5484D),
                    size: 21,
                  ),
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Profil şəklini sil',
                  style: TextStyle(
                    color: Color(0xFFE5484D),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFE5484D),
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
