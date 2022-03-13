import 'dart:math';

import 'package:app/app/injection.dart';
import 'package:app/extensions/iterable_extensions.dart';
import 'package:app/feature/core/puzzle_seed_cubit.dart';
import 'package:app/feature/puzzle/bloc/puzzle_cubit.dart';
import 'package:app/feature/supershape/supershape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

import '../../../widgets/fx/fx_on_action_scale.dart';
import '../../supershape/animated_supershape.dart';
import 'puzzle_background.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({
    required this.seed,
    this.isHackMode = false,
    Key? key,
  }) : super(key: key);

  final String seed;
  final bool isHackMode;

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late PuzzleCubit cubit;

  @override
  void didUpdateWidget(covariant PuzzleScreen oldWidget) {
    cubit = PuzzleCubit(getIt.get<PuzzleSeedCubit>().state.puzzle);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PuzzleBackground(),
          Center(
            child: LayoutBuilder(
              builder: (_, cstr) {
                final windowMinSize = max(350.0, cstr.maxWidth);
                final puzzleSize = min(400.0, windowMinSize);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Text('Puzzle Challenge', style: Theme.of(context).textTheme.headline5),
                      Text('Naturally best puzzle', style: Theme.of(context).textTheme.subtitle1),
                      const SizedBox(height: 16),
                      BlocBuilder<PuzzleCubit, PuzzleCubitState>(
                        bloc: cubit,
                        builder: (_, state) =>
                            Text('${state.moves}/∞ moves', style: Theme.of(context).textTheme.bodyText2),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: BlocBuilder<PuzzleCubit, PuzzleCubitState>(
                          bloc: cubit,
                          builder: (_, state) => PuzzleViewer(
                            puzzleCubit: cubit,
                            size: puzzleSize,
                            puzzle: state.puzzle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FxOnActionScale(
                            child: OutlinedButton.icon(
                              icon: Icon(MdiIcons.seed),
                              label: Text('Random Seed'),
                              onPressed: () => GoRouter.of(context).go('/'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          FxOnActionScale(
                            child: OutlinedButton.icon(
                              icon: Icon(MdiIcons.beeFlower),
                              label: Text('Find Seed'),
                              onPressed: () => GoRouter.of(context).go('/'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// PuzzleViewer manages animations and effects of the puzzle grid.
/// IDEA: Calculate how neighbouring influence each other (scaling, sides of the puzzle shrinking etc)
class PuzzleViewer extends StatelessWidget {
  PuzzleViewer({
    required this.size,
    required this.puzzle,
    required this.puzzleCubit,
    Key? key,
  }) : super(key: key);

  final double size;
  final List<int> puzzle;
  final PuzzleCubit puzzleCubit;

  late final Supershape supershape = Supershape.fromSeed(seed: getIt.get<PuzzleSeedCubit>().state.seed);

  double get tileSize => size / 4;

  @override
  Widget build(BuildContext context) {
    final shape = AnimatedSupershape(
      key: const ValueKey('bg-shape'),
      duration: const Duration(milliseconds: 1500),
      supershape: supershape,
      color1: Theme.of(context).colorScheme.primary,
      color2: Theme.of(context).colorScheme.primaryContainer,
      size: Size(tileSize, tileSize),
    );

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...puzzle.mapIndexed((e, i) {
            if (e == 16) return const SizedBox();
            return AnimatedPositioned(
              key: ValueKey('PuzzleTile-$e'),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              left: i % 4 * tileSize,
              top: i ~/ 4 * tileSize,
              child: FxOnActionScale(
                onTap: () => puzzleCubit.tap(i),
                onHoverScale: 0.9,
                onMouseDown: 0.85,
                child: PuzzleTile(
                  backgroundShape: shape,
                  size: tileSize,
                  value: e,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class PuzzleTile extends StatelessWidget {
  const PuzzleTile({
    required this.size,
    required this.value,
    required this.backgroundShape,
    Key? key,
  }) : super(key: key);

  /// max height and width of a puzzle tile
  final double size;
  final int value;
  final Widget backgroundShape;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(3.5),
        alignment: Alignment.center,
        height: size,
        width: size,
        child: Stack(
          children: [
            backgroundShape,
            Container(
              height: size,
              width: size,
              alignment: Alignment.center,
              constraints: const BoxConstraints.expand(),
              child: Text(
                value.toString(),
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
          ],
        ),
      );
}
