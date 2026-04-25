import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kalori_tracker/core/constants/app_text_styles.dart';

import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/guest_lock_card.dart';

class HydrationCard extends StatelessWidget {
  final bool isLoggedIn;

  const HydrationCard({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return const GuestLockCard(
        title: "Hidrasiya",
        message: "Daxil ol, gündəlik su istehlakını izləyək.",
      );
    }
    return const _HydrationContent();
  }
}

class _HydrationContent extends StatefulWidget {
  const _HydrationContent();

  @override
  State<_HydrationContent> createState() => _HydrationContentState();
}

class _HydrationContentState extends State<_HydrationContent>
    with TickerProviderStateMixin {
  static const double _recommended = 3.5;
  static const double _addAmount = 0.25;

  double _tracked = 1.8;

  late final AnimationController _waveController;
  late final AnimationController _fillController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fillAnimation = AlwaysStoppedAnimation(_tracked / _recommended);
  }

  void _addWater() {
    final newVal = (_tracked + _addAmount).clamp(0.0, _recommended);
    final oldFill = _tracked / _recommended;
    final newFill = newVal / _recommended;

    setState(() => _tracked = newVal);

    _fillAnimation = Tween<double>(
      begin: oldFill,
      end: newFill,
    ).animate(CurvedAnimation(parent: _fillController, curve: Curves.easeOut));
    _fillController
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? "${v.toInt()}L" : "${v.toStringAsFixed(1)}L";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFF1A3A8F),
        borderRadius: 20.br,
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([_waveController, _fillController]),
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _WavePainter(
                    progress: _waveController.value,
                    fillRatio: _fillAnimation.value,
                  ),
                ),
              ),
              child!,
            ],
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: 10.br,
                    ),
                    child: const Icon(
                      Icons.water_drop_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _fmt(_tracked),
                        style: AppTextStyles.h1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      4.hs,
                      Text(
                        "Tövsiyə: ${_fmt(_recommended)}",
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              16.hs,
              Text(
                "Hidrasiya",
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              16.hs,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: 12.br,
                ),
                child: Row(
                  children: [
                    Text(
                      "${_fmt(_tracked)} tracked today",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _addWater,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: 8.br,
                        ),
                        child: Text(
                          "ƏLAVƏ ET 250ML",
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A3A8F),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Wave Painter ─────────────────────────────────────────────────────────────

class _WavePainter extends CustomPainter {
  final double progress;
  final double fillRatio;

  const _WavePainter({required this.progress, required this.fillRatio});

  @override
  void paint(Canvas canvas, Size size) {
    final waterTop = size.height * (1 - fillRatio.clamp(0.0, 1.0));

    // Arxa dalğa
    _drawWave(
      canvas,
      size,
      color: const Color(0xFF2B5CE6).withOpacity(0.5),
      waterTop: waterTop,
      amplitude: 10,
      phaseShift: progress * 2 * pi + pi,
      wavelengthFactor: 0.7,
    );

    // Ön dalğa
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
  bool shouldRepaint(_WavePainter old) =>
      old.progress != progress || old.fillRatio != fillRatio;
}
