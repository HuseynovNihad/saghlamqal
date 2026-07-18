import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class RulerPicker extends StatefulWidget {
  const RulerPicker({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onChanged,
    this.step = 1,
    this.majorEvery = 10,
    this.pixelsPerStep = 12,
    this.decimals = 0,
  });

  final double min;
  final double max;
  final double initialValue;
  final double step;
  final int majorEvery;
  final double pixelsPerStep;
  final int decimals;
  final ValueChanged<double> onChanged;

  @override
  State<RulerPicker> createState() => _RulerPickerState();
}

class _RulerPickerState extends State<RulerPicker> {
  late final ScrollController _controller;
  late double _currentValue;

  int get _stepCount => ((widget.max - widget.min) / widget.step).round();

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.min, widget.max);
    final initialOffset =
        ((_currentValue - widget.min) / widget.step) * widget.pixelsPerStep;
    _controller = ScrollController(initialScrollOffset: initialOffset);
    _controller.addListener(_handleScroll);
  }

  void _handleScroll() {
    final raw =
        widget.min + (_controller.offset / widget.pixelsPerStep) * widget.step;
    final clamped = raw.clamp(widget.min, widget.max);
    final rounded = (clamped / widget.step).round() * widget.step;
    if (rounded != _currentValue) {
      setState(() => _currentValue = rounded);
      widget.onChanged(_currentValue);
    }
  }

  void _snapToNearest() {
    final index = ((_currentValue - widget.min) / widget.step).round();
    final target = index * widget.pixelsPerStep;
    _controller.animateTo(
      target.toDouble(),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth / 2;
        return SizedBox(
          height: 90,
          child: Stack(
            alignment: Alignment.center,
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    _snapToNearest();
                  }
                  return false;
                },
                child: ClipRect(
                  child: ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    itemCount: _stepCount + 1,
                    itemBuilder: (context, index) {
                      final value = widget.min + index * widget.step;
                      final isMajor = index % widget.majorEvery == 0;
                      return _Tick(
                        width: widget.pixelsPerStep,
                        isMajor: isMajor,
                        label: isMajor
                            ? value.toStringAsFixed(widget.decimals)
                            : null,
                      );
                    },
                  ),
                ),
              ),
              IgnorePointer(
                child: Container(
                  width: 3,
                  height: 42,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Tick extends StatelessWidget {
  const _Tick({required this.width, required this.isMajor, this.label});

  final double width;
  final bool isMajor;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: isMajor ? 2 : 1,
            height: isMajor ? 26 : 12,
            color: isMajor ? AppColors.headline : AppColors.borderColor,
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            SizedBox(
              height: 14,
              child: OverflowBox(
                minWidth: 0,
                maxWidth: 60,
                alignment: Alignment.center,
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.bodyText,
                  ),
                ),
              ),
            ),
          ] else
            const SizedBox(height: 14),
        ],
      ),
    );
  }
}
