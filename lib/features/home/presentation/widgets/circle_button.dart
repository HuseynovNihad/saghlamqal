import 'package:flutter/material.dart';

import '../../../../core/utils/padding_extension.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const CircleButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: 8.p,
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
