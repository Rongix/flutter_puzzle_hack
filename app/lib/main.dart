import 'package:app/app/injection.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  setupInjection();
  Paint.enableDithering = true;
  runApp(const App());
}
