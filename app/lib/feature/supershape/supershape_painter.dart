// ignore_for_file: cascade_invocations

import 'package:app/feature/supershape/supershape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SupershapePainter extends CustomPainter {
  const SupershapePainter({
    required this.supershape,
    required this.color,
    required this.shadow,
  });

  final Supershape supershape;
  final Color color;
  final Color shadow;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, 'Can not use non-square canvas');

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawShadow(supershape.path, shadow, 10, false);
    canvas.drawPath(supershape.path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}