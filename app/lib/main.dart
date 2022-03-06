import 'package:app/app/injection.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('assets/fonts/smooch_sans/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });

  setupInjection();
  runApp(const App());
}
