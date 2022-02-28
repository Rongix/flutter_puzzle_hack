import 'dart:developer';

import 'package:app/app/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'navigator_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerDelegate: AppRouterDelegate(),
      routeInformationParser: AppRouteInformationParser(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('HomeView')),
      );
}

class AppRouteInformationParser extends RouteInformationParser<NavigatorCubitState> {
  final NavigatorCubit navigator = getIt.get();

  @override
  SynchronousFuture<NavigatorCubitState> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(navigator.parseRouteInformation(routeInformation.location));
  }

  @override
  RouteInformation? restoreRouteInformation(NavigatorCubitState configuration) => RouteInformation(
        location: configuration.pathTemplate?.expand(configuration.pathParameters) ?? '/help',
      );
}

class AppRouterDelegate extends RouterDelegate<NavigatorCubitState> {
  final NavigatorCubit navigator = getIt.get();

  @override
  NavigatorCubitState get currentConfiguration => navigator.state;

  @override
  void addListener(VoidCallback listener) {
    log('Prefer NavigatorCubit instance for event listening');
    navigator.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    log('Prefer NavigatorCubit instance for event listening');
    navigator.removeListener(listener);
  }

  @override
  SynchronousFuture<bool> popRoute() => SynchronousFuture(navigator.canPop());

  @override
  SynchronousFuture<void> setNewRoutePath(NavigatorCubitState configuration) {
    return SynchronousFuture(navigator.forceUpdateState(configuration));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        const MaterialPage<void>(key: ValueKey('Home'), child: HomeView()),
        if (navigator.state.pathTemplate == NavigatorCubit.aboutPath)
          const MaterialPage<void>(
              key: ValueKey('About'), child: Scaffold(body: Center(child: Text('About'))))
      ],
      onPopPage: onPopPage,
    );
  }

  bool onPopPage(Route route, dynamic result) {
    return true;
  }
}
