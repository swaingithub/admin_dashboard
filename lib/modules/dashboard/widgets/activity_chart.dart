import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'dart:ui' as ui;
import '../../../core/theme/fx_colors.dart';

class ActivityChart extends StatelessWidget {
  const ActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Fluxy style: Use Fx.box for constraints instead of direct LayoutBuilder if possible,
    // but CustomPaint needs LayoutBuilder eventually.
    // However, we can use Fx() to make it reactive if colors changed dynamically.
    return Fx.box(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: _ChartPainter(FxColors.primary),
          );
        },
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final Color primaryColor;

  _ChartPainter(this.primaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height * 0.5),
        Offset(0, size.height),
        [primaryColor.withValues(alpha: 0.3), primaryColor.withValues(alpha: 0.0)],
      )
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.1, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.8),
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.3),
      Offset(size.width * 0.6, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.5),
      Offset(size.width * 0.9, size.height * 0.4),
      Offset(size.width, size.height * 0.1),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (var i = 1; i < points.length; i++) {
      // Quadratic bezier for smoothness
      final prevPoint = points[i - 1];
      final currentPoint = points[i];
      final xc = (prevPoint.dx + currentPoint.dx) / 2;
      path.quadraticBezierTo(prevPoint.dx, prevPoint.dy, xc, (prevPoint.dy + currentPoint.dy) / 2);
      fillPath.quadraticBezierTo(prevPoint.dx, prevPoint.dy, xc, (prevPoint.dy + currentPoint.dy) / 2);
    }
    
    path.lineTo(points.last.dx, points.last.dy);
    fillPath.lineTo(points.last.dx, points.last.dy);
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
    
    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
      
    for(int i=1; i<5; i++) {
       double y = size.height * (i/5);
       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
