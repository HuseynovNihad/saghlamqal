import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/enums/ai_analysis_step_status.dart';
import '../../../../../core/utils/padding_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoLoadingView extends StatefulWidget {
  final VoidCallback? onMinDurationElapsed;

  const PhotoLoadingView({super.key, this.onMinDurationElapsed});

  @override
  State<PhotoLoadingView> createState() => _PhotoLoadingViewState();
}

class _PhotoLoadingViewState extends State<PhotoLoadingView> {
  static const _steps = [
    _StepData('Şəkil uğurla çəkildi', 'Keyfiyyət yoxlanıldı'),
    _StepData('Məhsul analiz edilir', 'AI görüntünü araşdırır'),
    _StepData('Uyğun məhsul axtarılır', 'Verilənlər bazasında axtarış'),
    _StepData('Nəticə hazırlanır', 'Məlumatlar hazırlanır'),
  ];

  late final List<Duration> _stepDurations = _buildStepDurations();

  List<Duration> _buildStepDurations() {
    final totalMs = 10000 + Random().nextInt(5001);
    const weights = [0.5, 0.5];
    return [
      Duration.zero,
      Duration(milliseconds: (totalMs * weights[0]).round()),
      Duration(milliseconds: (totalMs * weights[1]).round()),
    ];
  }

  static const _extendedMessageDelay = Duration(seconds: 15);

  int _activeStep = 1;
  Timer? _timer;
  Timer? _extendedMessageTimer;
  bool _showExtendedMessage = false;

  @override
  void initState() {
    super.initState();
    _scheduleNext();

    _extendedMessageTimer = Timer(_extendedMessageDelay, () {
      if (!mounted) return;
      setState(() => _showExtendedMessage = true);
    });
  }

  void _scheduleNext() {
    if (_activeStep >= _steps.length - 1) {
      widget.onMinDurationElapsed?.call();
      return;
    }
    _timer = Timer(_stepDurations[_activeStep], () {
      if (!mounted) return;
      setState(() => _activeStep++);
      _scheduleNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _extendedMessageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            12.ws,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Məhsul analiz edilir...',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _showExtendedMessage
                          ? 'Bir az da davam edir, xahiş edirik gözləyin...'
                          : 'Bu adətən 10-15 saniyə çəkir',
                      key: ValueKey(_showExtendedMessage),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        24.hs,
        for (int i = 0; i < _steps.length; i++)
          _StepRow(
            key: ValueKey('step_$i'),
            data: _steps[i],
            status: i < _activeStep
                ? StepStatus.done
                : i == _activeStep
                ? StepStatus.active
                : StepStatus.pending,
            isLast: i == _steps.length - 1,
          ),
      ],
    );
  }
}

class _StepData {
  final String title;
  final String subtitle;

  const _StepData(this.title, this.subtitle);
}

class _StepRow extends StatelessWidget {
  final _StepData data;
  final StepStatus status;
  final bool isLast;

  const _StepRow({
    super.key,
    required this.data,
    required this.status,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _StepIndicator(status: status),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: status == StepStatus.done
                        ? AppColors.primary.withOpacity(0.3)
                        : Colors.grey.shade200,
                  ),
                ),
            ],
          ),
          12.ws,
          Expanded(
            child: Padding(
              padding: 20.pb,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: status == StepStatus.pending
                          ? Colors.grey
                          : Colors.black87,
                    ),
                  ),
                  Text(
                    data.subtitle,
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: 4.pt,
            child: _StatusTrailing(status: status),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final StepStatus status;

  const _StepIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepStatus.done:
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        );
      case StepStatus.active:
        return Container(
          width: 28,
          height: 28,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        );
      case StepStatus.pending:
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
        );
    }
  }
}

class _StatusTrailing extends StatelessWidget {
  final StepStatus status;

  const _StatusTrailing({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepStatus.done:
        return Text(
          'Tamamlandı',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        );
      case StepStatus.active:
        return const _WaveDots(color: AppColors.primary);
      case StepStatus.pending:
        return _WaveDots(color: Colors.grey.shade300, animate: false);
    }
  }
}

class _WaveDots extends StatefulWidget {
  final Color color;
  final bool animate;

  const _WaveDots({required this.color, this.animate = true});

  @override
  State<_WaveDots> createState() => _WaveDotsState();
}

class _WaveDotsState extends State<_WaveDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _dotCount = 3;
  static const _bounceHeight = 4.0;

  @override
  void initState() {
    super.initState();
    // Controller HƏMİŞƏ, animate false olsa belə, burda yaradılır.
    // Əks halda "late final" lazy şəkildə dispose() zamanı ilk dəfə
    // yaranmağa çalışır — bu da deaktivasiya olunmuş widget-in ancestor-unu
    // axtarmağa cəhd edib FlutterError atır.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.animate) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _WaveDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _offsetFor(int index, double t) {
    final phase = (t - index * 0.2) % 1.0;
    final wave = sin(phase * pi);
    return wave.clamp(0.0, 1.0) * _bounceHeight;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          _dotCount,
          (i) => _Dot(color: widget.color, dy: 0),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _dotCount,
            (i) => _Dot(color: widget.color, dy: -_offsetFor(i, t)),
          ),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double dy;

  const _Dot({required this.color, required this.dy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
