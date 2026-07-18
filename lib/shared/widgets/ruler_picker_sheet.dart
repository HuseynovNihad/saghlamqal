import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/app_colors.dart';
import 'ruler_picker.dart';

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
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return _RulerPickerSheetContent(
        title: title,
        min: min,
        max: max,
        initialValue: initialValue,
        step: step,
        majorEvery: majorEvery,
        unit: unit,
        decimals: decimals,
        allowManualInput: allowManualInput,
      );
    },
  );
}

class _RulerPickerSheetContent extends StatefulWidget {
  const _RulerPickerSheetContent({
    required this.title,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.step,
    required this.majorEvery,
    required this.unit,
    required this.decimals,
    required this.allowManualInput,
  });

  final String title;
  final double min;
  final double max;
  final double initialValue;
  final double step;
  final int majorEvery;
  final String unit;
  final int decimals;
  final bool allowManualInput;

  @override
  State<_RulerPickerSheetContent> createState() =>
      _RulerPickerSheetContentState();
}

class _RulerPickerSheetContentState extends State<_RulerPickerSheetContent> {
  late double _selected;
  late int
  _rulerKey; // ruler-i yeni dəyərə "jump" etdirmək üçün key dəyişdirilir
  bool _isEditing = false;
  late final TextEditingController _textController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue.clamp(widget.min, widget.max);
    _rulerKey = 0;
    _textController = TextEditingController(
      text: _selected.toStringAsFixed(widget.decimals),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _enterEditMode() {
    if (!widget.allowManualInput) return;
    setState(() {
      _isEditing = true;
      _textController.text = _selected.toStringAsFixed(widget.decimals);
      _textController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _textController.text.length,
      );
    });
    Future.microtask(() => _focusNode.requestFocus());
  }

  void _confirmTextInput() {
    final parsed = double.tryParse(_textController.text.replaceAll(',', '.'));
    setState(() {
      _isEditing = false;
      if (parsed != null) {
        _selected = parsed.clamp(widget.min, widget.max);
        _rulerKey++; // ruler-i yeni mövqeyə "teleport" et
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        28 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.bodyText,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: (_isEditing || !widget.allowManualInput)
                ? null
                : _enterEditMode,
            child: _isEditing
                ? SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*[.,]?\d*'),
                        ),
                      ],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: AppColors.headline,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        suffixText: widget.unit,
                        suffixStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.bodyText,
                        ),
                      ),
                      onSubmitted: (_) => _confirmTextInput(),
                      onEditingComplete: _confirmTextInput,
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _selected.toStringAsFixed(widget.decimals),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: AppColors.headline,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.unit}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.bodyText,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          if (widget.allowManualInput) ...[
            if (!_isEditing) ...[
              const SizedBox(height: 2),
              const Text(
                'Dəqiq rəqəm üçün toxunun',
                style: TextStyle(fontSize: 10, color: AppColors.bodyText),
              ),
            ] else
              const SizedBox(height: 16),
          ] else
            const SizedBox(height: 6),
          const SizedBox(height: 4),
          RulerPicker(
            key: ValueKey(_rulerKey),
            min: widget.min,
            max: widget.max,
            step: widget.step,
            majorEvery: widget.majorEvery,
            initialValue: _selected,
            decimals: widget.decimals,
            onChanged: (v) {
              if (!_isEditing) setState(() => _selected = v);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                if (_isEditing) _confirmTextInput();
                Navigator.pop(context, _selected);
              },
              child: const Text(
                'Təsdiqlə',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
