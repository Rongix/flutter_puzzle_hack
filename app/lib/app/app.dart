import 'package:app/feature/puzzle_screen/widget/puzzle_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String kAppName = '15Puzzle';
const String kAppNameHacked = '15✨Puzzle';

// Path param - seed | values: perferably 16alphanumeric characters (String), * => val
const String kPPSeed = 'seed';

// Query param - feature flag hack | values: [true, hack] => true, * => false
const String kQPHackMode = 'hack';
const List<String> kQPHackValues = ['hack', 'true', 'yes'];

bool computeIsHackMode(Map<String, String> query) {
  return kQPHackValues.contains(query[kQPHackMode]);
}

String computeAppName({required bool isHackMode}) {
  return isHackMode ? kAppNameHacked : kAppName;
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }

  final router = GoRouter(routes: [
    GoRoute(
      name: 'Hello 1',
      path: '/:seed',
      pageBuilder: (context, state) {
        final seed = state.params['seed'] ?? '';
        final isHackMode = computeIsHackMode(state.queryParams);
        final name = '${computeAppName(isHackMode: isHackMode)} seed: $seed';

        return MaterialPage<void>(
          name: name,
          child: PuzzleScreen(seed: seed),
        );
      },
    )
  ]);
}
