import 'dart:ui';
import 'package:flutter/material.dart';

class PhotoTipsPanel extends StatelessWidget {
  const PhotoTipsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.45)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TipItem(icon: Icons.wb_sunny_outlined, label: 'Yaxşı işıq'),
              _Divider(),
              _TipItem(icon: Icons.crop_outlined, label: 'Çərçivəyə sığdırın'),
              _Divider(),
              _TipItem(
                icon: Icons.stay_current_portrait_outlined,
                label: 'Sabit saxlayın',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TipItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: Colors.white24);
  }
}
