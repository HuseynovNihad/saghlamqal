import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/sized_box_extension.dart';

class PhotoFrame extends StatelessWidget {
  final bool isCapturing;

  const PhotoFrame({super.key, required this.isCapturing});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final frameSize = screenWidth * 0.78;
    final color = isCapturing ? AppColors.primary : const Color(0xFF7FE09A);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: frameSize,
          height: frameSize,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(cornerSize: 36, borderStrokeWidth: 2.5),
                ),
              ),
              ..._buildCorners(color),
            ],
          ),
        ),
        20.hs,
      ],
    );
  }

  List<Widget> _buildCorners(Color color) {
    const size = 36.0;
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

class _GridPainter extends CustomPainter {
  final double cornerSize;
  final double borderStrokeWidth;

  _GridPainter({this.cornerSize = 36.0, this.borderStrokeWidth = 1.5});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 0.8;

    for (int i = 1; i < 8; i++) {
      final y = size.height * i / 8;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (int i = 1; i < 8; i++) {
      final x = size.width * i / 8;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = borderStrokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(cornerSize, 0),
      Offset(size.width - cornerSize, 0),
      borderPaint,
    );
    canvas.drawLine(
      Offset(cornerSize, size.height),
      Offset(size.width - cornerSize, size.height),
      borderPaint,
    );
    canvas.drawLine(
      Offset(0, cornerSize),
      Offset(0, size.height - cornerSize),
      borderPaint,
    );
    canvas.drawLine(
      Offset(size.width, cornerSize),
      Offset(size.width, size.height - cornerSize),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
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

    const radius = 12.0;
    final path = Path();

    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius));
      path.lineTo(size.width, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(
        Offset(size.width, radius),
        radius: const Radius.circular(radius),
      );
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(size.width, size.height);
      path.lineTo(radius, size.height);
      path.arcToPoint(
        Offset(0, size.height - radius),
        radius: const Radius.circular(radius),
      );
      path.lineTo(0, 0);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(
        Offset(size.width - radius, size.height),
        radius: const Radius.circular(radius),
      );
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => old.color != color;
}
