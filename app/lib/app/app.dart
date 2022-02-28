import 'package:app/app/location_builders.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final BeamerDelegate routerDelegate = BeamerDelegate(
    locationBuilder: beamerLocationBuilder,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
