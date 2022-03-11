import 'dart:math';

import 'package:app/extensions/iterable_extensions.dart';
import 'package:app/feature/puzzle_screen/widget/puzzle_background.dart';
import 'package:app/feature/supershape/supershape.dart';
import 'package:app/widgets/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

import '../../supershape/animated_supershape.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PuzzleBackground(),
          Center(
            child: LayoutBuilder(
              builder: (_, cstr) {
                final windowMinSize = min(cstr.maxHeight, cstr.maxWidth);
                final puzzleSize = min(400.0, windowMinSize);

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Center(
                        child: PuzzleViewer(
                          size: puzzleSize,
                          isHackMode: widget.isHackMode,
                          seed: widget.seed,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => GoRouter.of(context).go('/'),
                                child: const Icon(MdiIcons.restart),
                              ),
                            ],
                          ),
                        ],
                      ),
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
    required this.isHackMode,
    required this.seed,
    Key? key,
  }) : super(key: key) {
    puzzle = generator.puzzleFromSeed(seed);
    supershape = Supershape.fromSeed(seed: seed);
  }

  final double size;
  final bool isHackMode;
  final String seed;

  static const SixteenPuzzleGenerator generator = SixteenPuzzleGenerator();

  late final List<int> puzzle;
  late final Supershape supershape;

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
            if (e == 16 && !isHackMode) return const SizedBox();
            return AnimatedPositioned(
              key: ValueKey('PuzzleTile-$e'),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              left: i % 4 * tileSize,
              top: i ~/ 4 * tileSize,
              child: Opacity(
                opacity: isHackMode && e == 16 ? 0.5 : 1,
                child: PuzzleTile(
                  seed: seed,
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
    required this.seed,
    Key? key,
  }) : super(key: key);

  /// max height and width of a puzzle tile
  final double size;
  final int value;
  final Widget backgroundShape;
  final String seed;

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
