import 'package:flutter/material.dart';

import '../../core/utils/border_extension.dart';
import '../../core/utils/padding_extension.dart';
import '../../core/utils/radius_extension.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? borderColor;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? 16.p,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 16.br,
          border: Colors.grey.withOpacity(0.2).all(width: 1.0),
        ),
        child: child,
      ),
    );
  }
}
