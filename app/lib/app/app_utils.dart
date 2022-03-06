import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const String kAppName = 'Puzzle';
const String kAppNameHacked = 'HackPuzzle';

// Path param - seed | values: perferably 16alphanumeric characters (String), * => val
const String kPPSeed = 'seed';

// Query param - feature flag hack | values: [true, yes] => true, * => false
const String kQPHackMode = 'hack';
const List<String> kQPHackValues = ['hack', 'true', 'yes'];

bool computeIsHackMode(Map<String, String> query) {
  return kQPHackValues.contains(query[kQPHackMode]);
}

String computeAppName({required bool isHackMode}) {
  return isHackMode ? kAppNameHacked : kAppName;
}

/// Change browser/tab title
Future<void> appSetSwitcherDescription({String? name, Color? color}) {
  return SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: name,
      primaryColor: color?.value,
    ),
  );
}
