import 'package:flutter/material.dart';

enum BreakpointType {
  mobilePortrait,
  mobileLandscape,
  tabletPortrait,
  tabletLandscape,
  desktop,
}

abstract class Breakpoint {
  /// Max mobile portrait < 640
  static const double mobilePortrait = 640.0;

  /// Max mobile landscape => 640 && < 778
  static const double mobileLandscape = 768.0;

  /// Max tablet portrait => 768 && < 1024
  static const double tabletPortrait = 1024.0;

  /// Max tablet landscape => 1024 && < 1280
  static const double tabletLandscape = 1280.0;

  /// Desktop
  static const double desktop = double.maxFinite;

  static BreakpointType breakpointFromConstraints(BoxConstraints constraints) {
    if (constraints.maxWidth < Breakpoint.mobilePortrait) return BreakpointType.mobilePortrait;
    if (constraints.maxWidth < Breakpoint.mobileLandscape) return BreakpointType.mobileLandscape;
    if (constraints.maxWidth < Breakpoint.tabletPortrait) return BreakpointType.tabletPortrait;
    if (constraints.maxWidth < Breakpoint.tabletLandscape) return BreakpointType.tabletLandscape;
    return BreakpointType.desktop;
  }
}

extension BreakpointTypeExtension on BreakpointType {
  T match<T>({
    required T onMobilePortrait,
    required T onMobileLandscape,
    required T onTabletPortrait,
    required T onTabletLandscape,
    required T onDesktop,
  }) {
    switch (this) {
      case BreakpointType.mobilePortrait:
        return onMobilePortrait;

      case BreakpointType.mobileLandscape:
        return onMobileLandscape;

      case BreakpointType.tabletPortrait:
        return onTabletPortrait;

      case BreakpointType.tabletLandscape:
        return onTabletLandscape;

      case BreakpointType.desktop:
        return onDesktop;
    }
  }
}
