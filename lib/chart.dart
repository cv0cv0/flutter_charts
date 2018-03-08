import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class Bar {
  Bar(this.height);

  final double height;

  static Bar lerp(Bar begin, Bar end, double t) {
    return new Bar(lerpDouble(begin.height, end.height, t));
  }
}

class BarTween extends Tween {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  lerp(double t) {
    return Bar.lerp(begin, end, t);
  }
}

class ChartPainter extends CustomPainter {
  static const barWidth = 15.0;

  ChartPainter(Animation animation)
      : animation = animation,
        super(repaint: animation);

  final Animation animation;

  @override
  void paint(Canvas canvas, Size size) {
    final bar = animation.value;
    final linePaint = new Paint()..color = Colors.grey[600];
    final rectPaint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawLine(
      new Offset(0.0, 0.0),
      new Offset(0.0, size.height),
      linePaint,
    );
    canvas.drawLine(
      new Offset(0.0, size.height),
      new Offset(size.width, size.height),
      linePaint,
    );
    canvas.drawRect(
        new Rect.fromLTWH(
          barWidth * 2,
          size.height - bar.height,
          barWidth,
          bar.height,
        ),
        rectPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
