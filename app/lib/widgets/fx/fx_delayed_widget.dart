import 'dart:async';

import 'package:flutter/material.dart';

class FxDelayedWidget extends StatefulWidget {
  const FxDelayedWidget({
    this.delay = const Duration(milliseconds: 300),
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget? child;
  final Duration delay;

  @override
  _FxDelayedWidgetState createState() => _FxDelayedWidgetState();
}

class _FxDelayedWidgetState extends State<FxDelayedWidget> {
  late Timer _timer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () => setState(() => _isVisible = true));
  }

  @override
  void didUpdateWidget(covariant FxDelayedWidget oldWidget) {
    if (oldWidget.child != widget.child) {
      _timer.cancel();
      setState(() => _isVisible = false);
      _timer = Timer(widget.delay, () => setState(() => _isVisible = true));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      child: _isVisible ? widget.child : const SizedBox.shrink(key: ValueKey('_DelayedWidgetState.hidden')),
    );
  }
}
