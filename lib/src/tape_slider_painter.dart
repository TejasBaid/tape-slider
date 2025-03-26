import 'package:flutter/material.dart';

class TapeScalePainter extends CustomPainter {
  final double min;
  final double max;
  final double itemExtent;
  final Axis orientation;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle majorTickLabelStyle;
  final TextStyle minorTickLabelStyle;
  final bool showLabels;
  final int tickInterval;
  final int labelInterval;

  TapeScalePainter({
    required this.min,
    required this.max,
    required this.itemExtent,
    required this.orientation,
    required this.activeColor,
    required this.inactiveColor,
    required this.majorTickLabelStyle,
    required this.minorTickLabelStyle,
    this.showLabels = true,
    this.tickInterval = 1,
    this.labelInterval = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isHorizontal = orientation == Axis.horizontal;

    final Paint majorTickPaint = Paint()
      ..color = activeColor
      ..strokeWidth = 2.0;

    final Paint minorTickPaint = Paint()
      ..color = inactiveColor
      ..strokeWidth = 1.5;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (double i = min; i <= max; i += tickInterval) {
      final position = (i - min) * itemExtent;
      final isMajorTick = i % labelInterval == 0;

      if (isHorizontal) {
        canvas.drawLine(
          Offset(position, size.height / 2 - (isMajorTick ? 30 : 20)),
          Offset(position, size.height / 2 + (isMajorTick ? 30 : 20)),
          isMajorTick ? majorTickPaint : minorTickPaint,
        );

        if (isMajorTick && showLabels) {
          textPainter.text = TextSpan(
            text: i.toInt().toString(),
            style: majorTickLabelStyle,
          );

          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(position - textPainter.width / 2, size.height / 2 + 40),
          );
        }
      } else {
        canvas.drawLine(
          Offset(size.width / 2 - (isMajorTick ? 30 : 20), position),
          Offset(size.width / 2 + (isMajorTick ? 30 : 20), position),
          isMajorTick ? majorTickPaint : minorTickPaint,
        );

        if (isMajorTick && showLabels) {
          textPainter.text = TextSpan(
            text: i.toInt().toString(),
            style: majorTickLabelStyle,
          );

          textPainter.layout();
          textPainter.paint(
            canvas,
            Offset(size.width / 2 + 40, position - textPainter.height / 2),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
