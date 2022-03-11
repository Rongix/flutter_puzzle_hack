// ignore_for_file: cascade_invocations
import 'dart:ui' as ui;

import 'package:app/feature/supershape/supershape.dart';
import 'package:flutter/material.dart';

class SupershapePainter extends CustomPainter {
  const SupershapePainter({
    required this.supershape,
    required this.color1,
    required this.color2,
  });

  final Supershape? supershape;
  final Color color1;
  final Color color2;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, 'Can not use non-square canvas');
    if (supershape == null) return;

    final radius = size.width / 2;

    // final paint = Paint()
    //   ..color = color ?? Colors.black
    //   ..style = PaintingStyle.fill;

    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(-radius, -radius),
        Offset(radius, radius),
        // radius,
        [color1, color2],
      );

    canvas.translate(radius, radius);
    final path = supershape!.path(radius * 0.8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SupershapePainter oldDelegate) => true;
}
