import 'package:app/app/app_utils.dart';
import 'package:app/feature/core/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../feature/core/puzzle_seed_cubit.dart';
import '../feature/puzzle/widget/puzzle_screen.dart';
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
    return BlocBuilder<ThemeCubit, ThemeSingletonState>(
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
          final puzzleSeed = getIt.get<PuzzleSeedCubit>()..randomSeed();
          return '/${puzzleSeed.state.seed}';
        }),
    GoRoute(
        path: '/:seed',
        pageBuilder: (context, state) {
          final seed = state.params['seed'] ?? '';
          const name = '15 Puzzle';
          getIt.get<ThemeCubit>().changeTheme(seed);
          getIt.get<PuzzleSeedCubit>().fromSeed(seed);

          appSetSwitcherDescription(name: name);

          return CustomTransitionPage<void>(
            transitionsBuilder: (context, anim1, anim2, child) => child,
            name: name,
            child: PuzzleScreen(seed: seed),
          );
        })
  ]);
}
