import 'package:flutter/material.dart';

class DietitianSectionHeader extends StatelessWidget {
  final String title;
  final String? badge;
  final String? trailing;
  final VoidCallback? onTap;

  const DietitianSectionHeader({
    super.key,
    required this.title,
    this.badge,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF112F38),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        if (badge != null) ...[
          const SizedBox(width: 8),
          Container(
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            padding: const EdgeInsets.symmetric(horizontal: 7),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5353),
              shape: BoxShape.circle,
            ),
            child: Text(
              badge!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],

        const Spacer(),

        if (trailing != null)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailing!,
                    style: const TextStyle(
                      color: Color(0xFF1FA862),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF1FA862),
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
