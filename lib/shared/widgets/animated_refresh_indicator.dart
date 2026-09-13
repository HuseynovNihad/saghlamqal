import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AnimatedRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const AnimatedRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<AnimatedRefreshIndicator> createState() =>
      _AnimatedRefreshIndicatorState();
}

class _AnimatedRefreshIndicatorState extends State<AnimatedRefreshIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;

  bool _isRefreshing = false;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      lowerBound: 0.94,
      upperBound: 1.06,
    );
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _isCompleted = false;
    });

    _rotationController.repeat();
    _pulseController.repeat(reverse: true);

    try {
      await widget.onRefresh();

      if (!mounted) return;

      _rotationController.stop();
      _pulseController.stop();

      setState(() {
        _isRefreshing = false;
        _isCompleted = true;
      });

      await Future.delayed(const Duration(milliseconds: 450));

      if (!mounted) return;

      setState(() {
        _isCompleted = false;
      });
    } finally {
      if (mounted) {
        _rotationController.stop();
        _pulseController.stop();

        if (_isRefreshing) {
          setState(() {
            _isRefreshing = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.noSpinner(
      elevation: 0,
      onRefresh: _handleRefresh,
      onStatusChange: (_) {},
      child: Stack(
        children: [
          widget.child,

          if (_isRefreshing || _isCompleted)
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(scale: animation, child: child),
                      );
                    },
                    child: _isCompleted
                        ? const _CompletedIndicator(key: ValueKey('completed'))
                        : _RefreshingIndicator(
                            key: const ValueKey('refreshing'),
                            rotationController: _rotationController,
                            pulseController: _pulseController,
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RefreshingIndicator extends StatelessWidget {
  final AnimationController rotationController;
  final AnimationController pulseController;

  const _RefreshingIndicator({
    super.key,
    required this.rotationController,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: pulseController,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotationController.value * math.pi * 2,
                  child: child,
                );
              },
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  size: 17,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(width: 9),

            const Text(
              'Yenilənir...',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletedIndicator extends StatelessWidget {
  const _CompletedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 25),
          SizedBox(width: 8),
          Text(
            'Yeniləndi',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
