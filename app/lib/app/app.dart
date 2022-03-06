import 'package:app/app/app_utils.dart';
import 'package:app/feature/puzzle_screen/widget/puzzle_screen.dart';
import 'package:app/feature/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

import 'injection.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ThemeCubit _themeCubit = getIt.get();

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
      bloc: _themeCubit,
      builder: (_, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: state.lightMode,
          darkTheme: state.darkMode,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
        );
      },
    );
  }

  final router = GoRouter(routes: [
    GoRoute(
        path: '/',
        redirect: (_) {
          const generator = SixteenPuzzleGenerator();
          final puzzle = generator.puzzleRandom();
          final randomSolvableSeed = generator.puzzleToSeed(puzzle);

          return '/$randomSolvableSeed';
        }),
    GoRoute(
        path: '/:seed',
        pageBuilder: (context, state) {
          final seed = state.params['seed'] ?? '';
          final isHackMode = computeIsHackMode(state.queryParams);
          final name = '${computeAppName(isHackMode: isHackMode)}: $seed';
          getIt.get<ThemeCubit>().changeTheme(seed);

          appSetSwitcherDescription(name: name);

          return CustomTransitionPage<void>(
            transitionsBuilder: (context, anim1, anim2, child) => child,
            name: name,
            child: PuzzleScreen(
              seed: seed,
              isHackMode: isHackMode,
            ),
          );
        })
  ]);
}
