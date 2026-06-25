import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double progress;
  final double fillRatio;

  const WavePainter({required this.progress, required this.fillRatio});

  @override
  void paint(Canvas canvas, Size size) {
    final waterTop = size.height * (1 - fillRatio.clamp(0.0, 1.0));

    _drawWave(
      canvas,
      size,
      color: const Color(0xFF2B5CE6).withOpacity(0.5),
      waterTop: waterTop,
      amplitude: 10,
      phaseShift: progress * 2 * pi + pi,
      wavelengthFactor: 0.7,
    );

    _drawWave(
      canvas,
      size,
      color: const Color(0xFF2B5CE6),
      waterTop: waterTop,
      amplitude: 8,
      phaseShift: progress * 2 * pi,
      wavelengthFactor: 1.0,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required Color color,
    required double waterTop,
    required double amplitude,
    required double phaseShift,
    required double wavelengthFactor,
  }) {
    final paint = Paint()..color = color;
    final wavelength = size.width * wavelengthFactor;
    final path = Path()..moveTo(0, waterTop);

    for (double x = 0; x <= size.width; x++) {
      final y =
          waterTop + amplitude * sin((x / wavelength * 2 * pi) + phaseShift);
      path.lineTo(x, y);
    }

    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter old) =>
      old.progress != progress || old.fillRatio != fillRatio;
}
