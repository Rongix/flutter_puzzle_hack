import 'package:app/app/app.dart';
import 'package:app/app/injection.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  Paint.enableDithering = true;
  if (UniversalPlatform.isDesktop) {
    DesktopWindow.setMinWindowSize(const Size(450, 450));
  }
  runApp(const App());
}
