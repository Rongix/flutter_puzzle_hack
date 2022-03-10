import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

typedef AutolayoutBuilder = Widget Function(BoxConstraints constraints, BreakpointType breakpoint);

/// 'Multiplatform' Layout builder - for platforms that let windows resize
/// Match screen size to proper layout builder.
class UniversalAutoLayout extends StatelessWidget {
  const UniversalAutoLayout({
    required this.onMobilePortrait,
    required this.onMobileLandscape,
    required this.onTabletPortrait,
    required this.onTabletLandscape,
    required this.onDesktop,
    Key? key,
  }) : super(key: key);

  final AutolayoutBuilder onMobilePortrait;
  final AutolayoutBuilder onMobileLandscape;
  final AutolayoutBuilder onTabletPortrait;
  final AutolayoutBuilder onTabletLandscape;
  final AutolayoutBuilder onDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final breakpoint = Breakpoint.breakpointFromConstraints(constraints);

      Widget callBuilder(AutolayoutBuilder fun) => fun.call(constraints, breakpoint);

      return breakpoint.match(
        onMobilePortrait: callBuilder(onMobilePortrait),
        onMobileLandscape: callBuilder(onMobileLandscape),
        onTabletPortrait: callBuilder(onTabletPortrait),
        onTabletLandscape: callBuilder(onTabletLandscape),
        onDesktop: callBuilder(onDesktop),
      );
    });
  }
}
