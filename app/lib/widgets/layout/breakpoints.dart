import 'package:flutter/material.dart';

enum BreakpointType {
  mobilePortrait,
  tabletPortrait,
  desktop,
}

abstract class Breakpoint {
  /// Max mobile portrait <= 640
  static const double mobilePortrait = 576.0;

  /// Max tablet portrait > 768 && <= 1024
  static const double tabletPortrait = 1024.0;

  /// Desktop
  static const double desktop = double.maxFinite;

  static BreakpointType breakpointFromConstraints(BoxConstraints constraints) {
    if (constraints.maxWidth <= Breakpoint.mobilePortrait)
      return BreakpointType.mobilePortrait;
    if (constraints.maxWidth <= Breakpoint.tabletPortrait)
      return BreakpointType.tabletPortrait;
    return BreakpointType.desktop;
  }
}

extension BreakpointTypeExtension on BreakpointType {
  T match<T>({
    required T onMobilePortrait,
    required T onTabletPortrait,
    required T onDesktop,
  }) {
    switch (this) {
      case BreakpointType.mobilePortrait:
        return onMobilePortrait;

      case BreakpointType.tabletPortrait:
        return onTabletPortrait;

      case BreakpointType.desktop:
        return onDesktop;
    }
  }
}
