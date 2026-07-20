import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/utils/radius_extension.dart';
import '../../core/utils/sized_box_extension.dart';

enum SnackBarType { success, error, warning, info }

enum SnackBarPosition { top, bottom }

class CustomSnackBar {
  static OverlayEntry? _currentTopEntry;
  static Timer? _currentTopTimer;

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.success,
    SnackBarPosition position = SnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (position == SnackBarPosition.bottom) {
      _showBottom(context, message: message, type: type, duration: duration);
    } else {
      _showTop(context, message: message, type: type, duration: duration);
    }
  }

  static void _showBottom(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _getColor(type),
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: 12.br),
        content: _SnackContent(message: message, icon: _getIcon(type)),
      ),
    );
  }

  static void _showTop(
    BuildContext context, {
    required String message,
    required SnackBarType type,
    required Duration duration,
  }) {
    // Əvvəlki üstdən açılan bildirişi ləğv edirik ki, üst-üstə düşməsin
    _currentTopTimer?.cancel();
    _currentTopEntry?.remove();
    _currentTopEntry = null;

    final overlay = Overlay.of(context, rootOverlay: true);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _TopSnackBarWidget(
        message: message,
        color: _getColor(type),
        icon: _getIcon(type),
        onDismissed: () {
          entry.remove();
          if (_currentTopEntry == entry) {
            _currentTopEntry = null;
          }
        },
      ),
    );

    _currentTopEntry = entry;
    overlay.insert(entry);

    _currentTopTimer = Timer(duration, () {
      if (_currentTopEntry == entry) {
        entry.remove();
        _currentTopEntry = null;
      }
    });
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}

class _SnackContent extends StatelessWidget {
  final String message;
  final IconData icon;

  const _SnackContent({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        10.ws,
        Expanded(
          child: Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismissed;

  const _TopSnackBarWidget({
    required this.message,
    required this.color,
    required this.icon,
    required this.onDismissed,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, topPadding > 0 ? 8 : 16, 16, 0),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _dismiss,
                onVerticalDragEnd: (details) {
                  if ((details.primaryVelocity ?? 0) < 0) _dismiss();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: 12.br,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _SnackContent(
                    message: widget.message,
                    icon: widget.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
