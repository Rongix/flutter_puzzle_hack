import 'dart:math';

import 'package:app/extensions/iterable_extensions.dart';
import 'package:app/feature/supershape/supershape.dart';
import 'package:app/feature/supershape/supershape_painter.dart';
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
  late SixteenPuzzleGenerator generator;
  late List<int> puzzleFromSeed;
  late Supershape supershape;

  bool isSelected = true;

  @override
  void didChangeDependencies() {
    generator = const SixteenPuzzleGenerator();
    puzzleFromSeed = generator.puzzleFromSeed(widget.seed);
    supershape = Supershape.fromSeed(seed: widget.seed, radius: 100 / 2 - 10);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final shape = AnimatedContainer(
    //   duration: const Duration(milliseconds: 300),
    //   height: 100,
    //   width: 100,
    //   margin: EdgeInsets.all(puzzleFromSeed[0] * 3),
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).cardTheme.color,
    //     borderRadius: BorderRadius.all(Radius.circular(puzzleFromSeed[0].toDouble())),
    //   ),
    // );

    final shape = AnimatedSupershape(
      duration: const Duration(milliseconds: 1500),
      supershape: supershape,
      color: Theme.of(context).cardTheme.color!,
      shadow: Theme.of(context).cardTheme.shadowColor!,
      size: const Size(100, 100),
    );

    // CustomPaint(
    //   size: const Size(100, 100),
    //   painter: SupershapePainter(
    //     supershape: supershape,
    //     color: Theme.of(context).cardTheme.color!,
    //     shadow: Theme.of(context).cardTheme.shadowColor!,
    //   ),
    // );

    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (_, cstr) {
            final windowMinSize = min(cstr.maxHeight, cstr.maxWidth);
            final puzzleSize = min(400.0, windowMinSize);

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: PuzzleViewer(
                      backgroundShape: shape,
                      size: puzzleSize,
                      puzzle: puzzleFromSeed,
                      isHackMode: widget.isHackMode,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () => GoRouter.of(context).go('/'),
                            icon: const Icon(MdiIcons.newBox),
                          ),
                          Text('Reload', style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                      // AnimatedContainer(),
                      // const SizedBox(width: 32),
                      // Column(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(MdiIcons.github),
                      //     ),
                      //     Text('Github', style: Theme.of(context).textTheme.caption),
                      //   ],
                      // ),
                      // const SizedBox(width: 32),
                      // Column(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(MdiIcons.linkedin),
                      //     ),
                      //     Text('LinkedIn', style: Theme.of(context).textTheme.caption),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// PuzzleViewer manages animations and effects of the puzzle grid.
/// IDEA: Calculate how neighbouring influence each other (scaling, sides of the puzzle shrinking etc)
class PuzzleViewer extends StatelessWidget {
  const PuzzleViewer({
    required this.size,
    required this.puzzle,
    required this.isHackMode,
    required this.backgroundShape,
    Key? key,
  }) : super(key: key);

  /// height and width of a puzzle
  final double size;
  final List<int> puzzle;
  final bool isHackMode;
  final Widget backgroundShape;

  @override
  Widget build(BuildContext context) {
    final tileSize = size / 4;

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
                  backgroundShape: backgroundShape,
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
              child: SelectableText(
                value.toString(),
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
            // Card(
            //   margin: EdgeInsets.zero,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child:
            // ),
          ],
        ),
      );
}
