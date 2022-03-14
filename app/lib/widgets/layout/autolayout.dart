import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

typedef AutolayoutBuilder = Widget Function(BoxConstraints constraints, BreakpointType breakpoint);

/// 'Multiplatform' Layout builder - for platforms that let windows resize
/// Match screen size to proper layout builder.
class UniversalAutoLayout extends StatelessWidget {
  const UniversalAutoLayout({
    required this.onSmall,
    required this.onMedium,
    required this.onLarge,
    Key? key,
  }) : super(key: key);

  final AutolayoutBuilder onSmall;
  final AutolayoutBuilder onMedium;
  final AutolayoutBuilder onLarge;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final breakpoint = Breakpoint.breakpointFromConstraints(constraints);

      Widget callBuilder(AutolayoutBuilder fun) => fun.call(constraints, breakpoint);

      return breakpoint.match(
        onMobilePortrait: callBuilder(onSmall),
        onTabletPortrait: callBuilder(onMedium),
        onDesktop: callBuilder(onLarge),
      );
    });
  }
}
