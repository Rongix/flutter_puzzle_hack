import 'package:app/feature/supershape/supershape.dart';
import 'package:app/feature/supershape/supershape_painter.dart';
import 'package:flutter/material.dart';

class AnimatedSupershape extends ImplicitlyAnimatedWidget {
  const AnimatedSupershape({
    required this.supershape,
    required Duration duration,
    required this.size,
    this.color,
    this.shadow,
    Curve curve = Curves.easeOutQuart,
    Key? key,
  }) : super(duration: duration, curve: curve, key: key);

  final Supershape supershape;
  final Color? color;
  final Color? shadow;
  final Size size;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _AnimatedSupershapeState();
}

class _AnimatedSupershapeState extends AnimatedWidgetBaseState<AnimatedSupershape> {
  SupershapeTween? _supershape;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _supershape = visitor(
            _supershape, widget.supershape, (dynamic value) => SupershapeTween(begin: value as Supershape))
        as SupershapeTween?;
  }

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    return CustomPaint(
      size: widget.size,
      painter: SupershapePainter(
        supershape: _supershape?.evaluate(animation),
        color: widget.color,
        shadow: widget.shadow,
      ),
    );
  }
}
