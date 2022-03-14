import 'package:app/app/app_utils.dart';
import 'package:app/feature/core/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../feature/404/unknown_screen.dart';
import '../feature/core/puzzle_seed_cubit.dart';
import '../feature/home/home_screen.dart';
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

  final router = GoRouter(
      errorBuilder: (context, state) {
        appSetSwitcherDescription(name: '15 Puzzle 404');

        return const UnknownScreen();
      },
      routes: [
        GoRoute(
          path: '/r/puzzle',
          redirect: (_) {
            final seedCubit = getIt.get<PuzzleSeedCubit>()..randomSeed();
            return '/${seedCubit.state.seed}';
          },
        ),
        GoRoute(
          path: '/',
          builder: (_, state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
            path: '/:seed',
            builder: (_, state) {
              final seed = state.params['seed'] ?? '';
              const name = '15 Puzzle';
              final seedCubit = getIt.get<PuzzleSeedCubit>()..fromSeed(seed);

              appSetSwitcherDescription(name: name);

              if (seedCubit.state.appException == null) {
                getIt.get<ThemeCubit>().changeTheme(seed);
                return PuzzleScreen(seed: seed);
              }
              return const UnknownScreen();
            }),
      ]);
}
