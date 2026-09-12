import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/app_colors.dart';

Future<double?> showRulerPickerSheet({
  required BuildContext context,
  required String title,
  required double min,
  required double max,
  required double initialValue,
  double step = 1,
  int majorEvery = 10,
  String unit = '',
  int decimals = 0,
  bool allowManualInput = true,
}) {
  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.35),
    builder: (context) {
      return _SmartValuePickerSheet(
        title: title,
        min: min,
        max: max,
        initialValue: initialValue,
        step: step,
        unit: unit,
        decimals: decimals,
        allowManualInput: allowManualInput,
      );
    },
  );
}

class _SmartValuePickerSheet extends StatefulWidget {
  const _SmartValuePickerSheet({
    required this.title,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.step,
    required this.unit,
    required this.decimals,
    required this.allowManualInput,
  });

  final String title;
  final double min;
  final double max;
  final double initialValue;
  final double step;
  final String unit;
  final int decimals;
  final bool allowManualInput;

  @override
  State<_SmartValuePickerSheet> createState() => _SmartValuePickerSheetState();
}

class _SmartValuePickerSheetState extends State<_SmartValuePickerSheet> {
  late int _selectedIndex;

  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  bool _isEditing = false;

  double get _safeStep {
    if (widget.step <= 0) {
      return 1;
    }

    return widget.step;
  }

  int get _totalSteps {
    if (widget.max <= widget.min) {
      return 0;
    }

    return ((widget.max - widget.min) / _safeStep).round();
  }

  double get _selectedValue {
    return _valueFromIndex(_selectedIndex);
  }

  bool get _canDecrease {
    return _selectedIndex > 0;
  }

  bool get _canIncrease {
    return _selectedIndex < _totalSteps;
  }

  @override
  void initState() {
    super.initState();

    _selectedIndex = _indexFromValue(widget.initialValue);

    _textController = TextEditingController(text: _formatValue(_selectedValue));

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  int _indexFromValue(double value) {
    final safeValue = value.clamp(widget.min, widget.max).toDouble();

    final index = ((safeValue - widget.min) / _safeStep).round();

    return index.clamp(0, _totalSteps);
  }

  double _valueFromIndex(int index) {
    final safeIndex = index.clamp(0, _totalSteps);

    final value = widget.min + (safeIndex * _safeStep);

    return value.clamp(widget.min, widget.max).toDouble();
  }

  String _formatValue(double value) {
    return value.toStringAsFixed(widget.decimals);
  }

  void _decrease() {
    if (!_canDecrease) {
      return;
    }

    HapticFeedback.selectionClick();

    setState(() {
      _selectedIndex--;
    });
  }

  void _increase() {
    if (!_canIncrease) {
      return;
    }

    HapticFeedback.selectionClick();

    setState(() {
      _selectedIndex++;
    });
  }

  void _startManualInput() {
    if (!widget.allowManualInput) {
      return;
    }

    if (_isEditing) {
      return;
    }

    _textController.text = _formatValue(_selectedValue);

    _textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textController.text.length,
    );

    setState(() {
      _isEditing = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _focusNode.requestFocus();
    });
  }

  void _finishManualInput() {
    if (!_isEditing) {
      return;
    }

    final rawValue = _textController.text.trim().replaceAll(',', '.');

    final parsed = double.tryParse(rawValue);

    if (parsed != null) {
      final clampedValue = parsed.clamp(widget.min, widget.max).toDouble();

      _selectedIndex = _indexFromValue(clampedValue);
    }

    _focusNode.unfocus();

    setState(() {
      _isEditing = false;
    });

    _textController.text = _formatValue(_selectedValue);
  }

  void _confirm() {
    if (_isEditing) {
      _finishManualInput();
    }

    Navigator.of(context).pop<double>(_selectedValue);
  }

  List<double> _getQuickValues() {
    if (_totalSteps == 0) {
      return [widget.min];
    }

    final center = _selectedValue;

    double quickStep;

    if (widget.step <= 1) {
      quickStep = 5;
    } else {
      quickStep = widget.step * 5;
    }

    final candidates = <double>[center - quickStep, center, center + quickStep];

    final result = <double>[];

    for (final value in candidates) {
      final clamped = value.clamp(widget.min, widget.max).toDouble();

      final normalized = _valueFromIndex(_indexFromValue(clamped));

      final alreadyExists = result.any(
        (item) => (item - normalized).abs() < 0.000001,
      );

      if (!alreadyExists) {
        result.add(normalized);
      }
    }

    return result;
  }

  void _selectQuickValue(double value) {
    HapticFeedback.selectionClick();

    setState(() {
      _selectedIndex = _indexFromValue(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHandle(),

                const SizedBox(height: 18),

                _buildHeader(),

                const SizedBox(height: 24),

                _buildMainValueCard(),

                const SizedBox(height: 16),

                _buildQuickValueChips(),

                if (widget.allowManualInput) ...[
                  const SizedBox(height: 10),
                  _buildManualInputButton(),
                ],

                const SizedBox(height: 24),

                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 42,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.headline,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Material(
          color: AppColors.textfieldColor,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const SizedBox(
              width: 38,
              height: 38,
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: AppColors.bodyText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainValueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.textfieldColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          _ValueButton(
            icon: Icons.remove_rounded,
            enabled: _canDecrease,
            onTap: _decrease,
          ),

          const SizedBox(width: 12),

          Expanded(child: _buildValueContent()),

          const SizedBox(width: 12),

          _ValueButton(
            icon: Icons.add_rounded,
            enabled: _canIncrease,
            onTap: _increase,
          ),
        ],
      ),
    );
  }

  Widget _buildValueContent() {
    if (_isEditing && widget.allowManualInput) {
      return TextField(
        controller: _textController,
        focusNode: _focusNode,
        autofocus: false,
        textAlign: TextAlign.center,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.numberWithOptions(
          decimal: widget.decimals > 0,
          signed: false,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
        ],
        onSubmitted: (_) {
          _finishManualInput();
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        style: const TextStyle(
          color: AppColors.headline,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.allowManualInput ? _startManualInput : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _formatValue(_selectedValue),
                    style: const TextStyle(
                      color: AppColors.headline,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (widget.unit.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Text(
                      widget.unit,
                      style: const TextStyle(
                        color: AppColors.bodyText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (widget.allowManualInput) ...[
              const SizedBox(height: 3),

              const Text(
                'Dəyişmək üçün rəqəmə toxunun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.bodyText,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickValueChips() {
    final values = _getQuickValues();

    if (values.length <= 1) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        for (int i = 0; i < values.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),

          Expanded(
            child: _QuickValueChip(
              value: _formatValue(values[i]),
              unit: widget.unit,
              selected: (values[i] - _selectedValue).abs() < 0.000001,
              onTap: () {
                _selectQuickValue(values[i]);
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildManualInputButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _startManualInput,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_rounded, size: 15, color: AppColors.bodyText),
              SizedBox(width: 6),
              Text(
                'Rəqəmi əl ilə daxil et',
                style: TextStyle(
                  color: AppColors.bodyText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _confirm,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Təsdiqlə',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _ValueButton extends StatelessWidget {
  const _ValueButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.35,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: enabled ? onTap : null,
          child: SizedBox(
            width: 52,
            height: 52,
            child: Icon(icon, size: 25, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

class _QuickValueChip extends StatelessWidget {
  const _QuickValueChip({
    required this.value,
    required this.unit,
    required this.selected,
    required this.onTap,
  });

  final String value;
  final String unit;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withOpacity(0.08)
          : AppColors.textfieldColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 42,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.borderColor,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              unit.isEmpty ? value : '$value $unit',
              maxLines: 1,
              style: TextStyle(
                color: selected ? AppColors.primary : AppColors.bodyText,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
