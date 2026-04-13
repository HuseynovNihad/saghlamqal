import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utils/radius_extension.dart';
import '../../../../../core/utils/sized_box_extension.dart';
import 'scan_line.dart';

class ScanFrame extends StatelessWidget {
  final bool isDetected;

  const ScanFrame({super.key, required this.isDetected});

  @override
  Widget build(BuildContext context) {
    final color = isDetected ? AppColors.primary : Colors.white;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color.withOpacity(0.3), width: 1),
                  borderRadius: 16.br,
                ),
              ),
              ..._buildCorners(color),
              if (!isDetected) const ScanLine(),
            ],
          ),
        ),
        24.hs,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: 24.br,
          ),
          child: Text(
            isDetected ? "Barkod tapıldı ✓" : "Barkodu çərçivəyə tutun",
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCorners(Color color) {
    const size = 24.0;
    const thickness = 3.0;

    return [
      Positioned(
        top: 0,
        left: 0,
        child: _Corner(
          color: color,
          size: size,
          thickness: thickness,
          top: true,
          left: true,
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: _Corner(
          color: color,
          size: size,
          thickness: thickness,
          top: true,
          left: false,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: _Corner(
          color: color,
          size: size,
          thickness: thickness,
          top: false,
          left: true,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: _Corner(
          color: color,
          size: size,
          thickness: thickness,
          top: false,
          left: false,
        ),
      ),
    ];
  }
}

class _Corner extends StatelessWidget {
  final Color color;
  final double size;
  final double thickness;
  final bool top;
  final bool left;

  const _Corner({
    required this.color,
    required this.size,
    required this.thickness,
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(
          color: color,
          thickness: thickness,
          top: top,
          left: left,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool top;
  final bool left;

  _CornerPainter({
    required this.color,
    required this.thickness,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => old.color != color;
}
