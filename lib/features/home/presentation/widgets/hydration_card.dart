import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalori_tracker/core/constants/app_assets.dart';
import 'package:kalori_tracker/core/constants/app_colors.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/asset_extension.dart';
import '../../../../core/utils/radius_extension.dart';
import '../../../../core/utils/sized_box_extension.dart';
import '../../../../shared/widgets/shimmer_box.dart';
import '../../domain/entities/hydration_entity.dart';
import '../bloc/home_bloc.dart';
import '../painters/wave_painter.dart';

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
                  painter: WavePainter(
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

class _HydrationSkeleton extends StatelessWidget {
  const _HydrationSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 20.br,
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: 36, height: 36, radius: 10),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ShimmerBox(width: 60, height: 20, radius: 6),
                  4.hs,
                  ShimmerBox(width: 90, height: 12, radius: 6),
                ],
              ),
            ],
          ),
          16.hs,
          ShimmerBox(width: 80, height: 18, radius: 6),
          16.hs,
          ShimmerBox(width: double.infinity, height: 44, radius: 12),
        ],
      ),
    );
  }
}
