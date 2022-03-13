import 'package:app/app/injection.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_size/window_size.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  Paint.enableDithering = true;
  if (UniversalPlatform.isDesktop) {
    setWindowMinSize(const Size(350, 350));
  }
  runApp(const App());
}
