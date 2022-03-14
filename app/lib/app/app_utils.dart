import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Change browser/tab title
Future<void> appSetSwitcherDescription({String? name, Color? color}) {
  return SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: name,
      primaryColor: color?.value,
    ),
  );
}
