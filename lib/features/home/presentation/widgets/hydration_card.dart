import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../domain/entities/hydration_entity.dart';
import '../bloc/home_bloc.dart';

class HydrationCard extends StatelessWidget {
  final HomeState state;

  const HydrationCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) {
      return const _HydrationSkeleton();
    }

    if (state is HomeLoaded) {
      return _HydrationContent(hydration: (state as HomeLoaded).hydration);
    }

    return const SizedBox.shrink();
  }
}

class _HydrationContent extends StatefulWidget {
  final HydrationEntity hydration;

  const _HydrationContent({required this.hydration});

  @override
  State<_HydrationContent> createState() => _HydrationContentState();
}

class _HydrationContentState extends State<_HydrationContent>
    with TickerProviderStateMixin {
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

    _fillAnimation = AlwaysStoppedAnimation(widget.hydration.fillRatio);
  }

  @override
  void didUpdateWidget(_HydrationContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hydration.consumed != widget.hydration.consumed) {
      final oldFill = oldWidget.hydration.fillRatio;
      final newFill = widget.hydration.fillRatio;

      _fillAnimation = Tween<double>(begin: oldFill, end: newFill).animate(
        CurvedAnimation(parent: _fillController, curve: Curves.easeOut),
      );
      _fillController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? '${v.toInt()}L' : '${v.toStringAsFixed(2)}L';

  @override
  Widget build(BuildContext context) {
    final hydration = widget.hydration;

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
                    child: AppAssets.hydration.svg(
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _fmt(hydration.consumed),
                        style: AppTextStyles.h2.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      4.hs,
                      Text(
                        'Tövsiyə: ${_fmt(hydration.dailyGoal)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              16.hs,
              Text(
                'Hidrasiya',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [0.25, 0.5, 0.75].map((amount) {
                    return GestureDetector(
                      onTap: () => context.read<HomeBloc>().add(
                        HomeAddWaterPressed(amount: amount),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: 8.br,
                        ),
                        child: Text(
                          '+${amount}L',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A3A8F),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  final double fillRatio;

  const _WavePainter({required this.progress, required this.fillRatio});

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
  bool shouldRepaint(_WavePainter old) =>
      old.progress != progress || old.fillRatio != fillRatio;
}

class _HydrationSkeleton extends StatelessWidget {
  const _HydrationSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: 20.br,
      ),
    );
  }
}
