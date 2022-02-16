import 'package:app/app/injection.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';

void main() {
  injection();
  setPathUrlStrategy();
  runApp(const App());
}
