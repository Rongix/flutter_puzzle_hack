import 'package:flutter/material.dart';

/// Scaled widget according to tap up/down and mouse region actions
/// A base component for clickable elements
class FxOnActionScale extends StatefulWidget {
  const FxOnActionScale({
    required this.child,
    this.isActive = true,
    this.duration = const Duration(milliseconds: 167),
    this.onMouseDown = 0.9,
    this.onHoverScale = 0.95,
    Key? key,
  }) : super(key: key);

  final Widget? child;
  final bool isActive;
  final Duration duration;

  final double onHoverScale;
  final double onMouseDown;

  @override
  _FxOnActionScaleState createState() => _FxOnActionScaleState();
}

class _FxOnActionScaleState extends State<FxOnActionScale> {
  bool _isScaledDown = false;
  bool _isMouseHoover = false;

  @override
  Widget build(BuildContext context) {
    final scale = (_isScaledDown || _isMouseHoover)
        ? (_isMouseHoover && _isScaledDown)
            ? widget.onMouseDown
            : widget.onHoverScale
        : 1.0;

    return MouseRegion(
      onEnter: (_) => _updateMouseHoover(true),
      onExit: (_) => _updateMouseHoover(false),
      child: AnimatedScale(
        duration: widget.duration,
        scale: scale,
        curve: Curves.decelerate,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (_) => _updateScaledDown(true),
          onTapUp: (_) => _updateScaledDown(false),
          onTapCancel: () => _updateScaledDown(false),
          child: widget.child,
        ),
      ),
    );
  }

  void _updateMouseHoover(bool value) {
    if (!widget.isActive) return;
    setState(() => _isMouseHoover = value);
  }

  void _updateScaledDown(bool value) {
    if (!widget.isActive) return;
    setState(() => _isScaledDown = value);
  }
}
