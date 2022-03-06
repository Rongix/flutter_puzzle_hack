import 'package:app/feature/supershape/supershape.dart';
import 'package:app/feature/supershape/supershape_painter.dart';
import 'package:flutter/material.dart';

class AnimatedSupershape extends ImplicitlyAnimatedWidget {
  const AnimatedSupershape({
    required this.supershape,
    required Duration duration,
    required this.color,
    required this.shadow,
    required this.size,
    Curve curve = Curves.easeOutQuart,
  }) : super(duration: duration, curve: curve);

  final Supershape supershape;
  final Color color;
  final Color shadow;
  final Size size;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _AnimatedSupershapeState();
}

class _AnimatedSupershapeState extends AnimatedWidgetBaseState<AnimatedSupershape> {
  SupershapeTween? _supershape;
  ColorTween? _color;
  ColorTween? _shadow;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _supershape = visitor(
            _supershape, widget.supershape, (dynamic value) => SupershapeTween(begin: value as Supershape))
        as SupershapeTween?;
    _color =
        visitor(_color, widget.color, (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
    _shadow =
        visitor(_shadow, widget.shadow, (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    return CustomPaint(
      size: widget.size,
      painter: SupershapePainter(
        supershape: _supershape?.evaluate(animation),
        color: _color?.evaluate(animation),
        shadow: _shadow?.evaluate(animation),
      ),
    );
  }
}
