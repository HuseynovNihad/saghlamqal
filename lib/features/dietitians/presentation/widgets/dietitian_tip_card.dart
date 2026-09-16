import 'package:flutter/material.dart';

class DietitianTipCard extends StatelessWidget {
  const DietitianTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF8F0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Row(
        children: [
          _TipIcon(),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dietoloqunla müntəzəm əlaqə saxlayaraq '
              'hədəflərinə daha tez çata bilərsən.',
              style: TextStyle(
                color: Color(0xFF41615A),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipIcon extends StatelessWidget {
  const _TipIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFDDF4E7),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lightbulb_outline_rounded,
        color: Color(0xFF22A760),
        size: 23,
      ),
    );
  }
}
