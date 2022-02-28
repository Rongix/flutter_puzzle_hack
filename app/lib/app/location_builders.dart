import 'package:app/feature/home_screen/widget/home_screen.dart';
import 'package:app/feature/puzzle_screen/widget/puzzle_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final beamerLocationBuilder = BeamerLocationBuilder(
  beamLocations: [
    HomeLocation(),
    PuzzleLocation(),
  ],
);

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

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final isHackMode = computeIsHackMode(state.queryParameters);
    final appName = computeAppName(isHackMode: isHackMode);

    return [
      BeamPage(
        title: '$appName: Home',
        key: const ValueKey('home'),
        child: const HomeScreen(),
      ),
    ];
  }
}

class PuzzleLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['/:$kPPSeed'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final beamPages = [...HomeLocation().buildPages(context, state)];

    if (state.pathParameters.containsKey(kPPSeed)) {
      final seed = state.pathParameters[kPPSeed]!;

      final isHackMode = computeIsHackMode(state.queryParameters);
      final appName = computeAppName(isHackMode: isHackMode);

      final key = ValueKey('$appName-$seed');
      final title = '$appName $seed';

      beamPages.add(
        BeamPage(
          title: title,
          key: key,
          type: BeamPageType.fadeTransition,
          child: PuzzleScreen(seed: seed),
        ),
      );
    }

    return beamPages;
  }
}
