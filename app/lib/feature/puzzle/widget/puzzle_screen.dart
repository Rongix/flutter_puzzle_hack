import 'package:app/app/injection.dart';
import 'package:app/extensions/iterable_extensions.dart';
import 'package:app/feature/core/puzzle_seed_cubit.dart';
import 'package:app/feature/puzzle/bloc/puzzle_cubit.dart';
import 'package:app/feature/supershape/supershape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../widgets/fx/fx_on_action_scale.dart';
import '../../supershape/animated_supershape.dart';
import '../bloc/intents.dart';
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Text('Puzzle Challenge', style: Theme.of(context).textTheme.headline5),
                      Text('Naturally best puzzle', style: Theme.of(context).textTheme.subtitle1),
                      const SizedBox(height: 16),
                      BlocSelector<PuzzleCubit, PuzzleCubitState, int>(
                        selector: (state) => state.moves,
                        bloc: cubit,
                        builder: (_, moves) =>
                            Text('$moves/∞ moves', style: Theme.of(context).textTheme.bodyText2),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: PuzzleViewer(
                          puzzleCubit: cubit,
                          size: 400,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FxOnActionScale(
                            child: OutlinedButton.icon(
                              icon: const Icon(MdiIcons.seed),
                              label: const Text('Random Seed'),
                              onPressed: () => GoRouter.of(context).go('/'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          FxOnActionScale(
                            child: OutlinedButton.icon(
                              icon: const Icon(MdiIcons.beeFlower),
                              label: const Text('Find Seed'),
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
class PuzzleViewer extends StatefulWidget {
  const PuzzleViewer({
    required this.size,
    required this.puzzleCubit,
    Key? key,
  }) : super(key: key);

  final double size;
  final PuzzleCubit puzzleCubit;

  @override
  State<PuzzleViewer> createState() => _PuzzleViewerState();
}

class _PuzzleViewerState extends State<PuzzleViewer> {
  final PuzzleSeedCubit _puzzleSeedCubit = getIt.get();
  late final FocusNode _focusNode;

  double get tileSize => widget.size / 4;

  @override
  void initState() {
    super.initState();

    /// Not a perfect solution - after clicking a button we're regaining focus
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) _focusNode.requestFocus();
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        autofocus: true,
        shortcuts: {
          moveRightKeySet: MoveRightIntent(),
          moveRightKeyV2Set: MoveRightIntent(),
          moveLeftKeySet: MoveLeftIntent(),
          moveLeftKeyV2Set: MoveLeftIntent(),
          moveUpKeySet: MoveUpIntent(),
          moveUpKeyV2Set: MoveUpIntent(),
          moveDownKeySet: MoveDownIntent(),
          moveDownKeyV2Set: MoveDownIntent(),
          swipeRightKeySet: SwipeRightIntent(),
          swipeRightKeyV2Set: SwipeRightIntent(),
          swipeLeftKeySet: SwipeLeftIntent(),
          swipeLeftKeyV2Set: SwipeLeftIntent(),
          swipeUpKeySet: SwipeUpIntent(),
          swipeUpKeyV2Set: SwipeUpIntent(),
          swipeDownKeySet: SwipeDownIntent(),
          swipeDownKeyV2Set: SwipeDownIntent(),
        },
        actions: {
          MoveRightIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.right, false),
          ),
          MoveLeftIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.left, false),
          ),
          MoveUpIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.up, false),
          ),
          MoveDownIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.down, false),
          ),
          SwipeRightIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.right, true),
          ),
          SwipeLeftIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.left, true),
          ),
          SwipeUpIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.up, true),
          ),
          SwipeDownIntent: CallbackAction(
            onInvoke: (_) => widget.puzzleCubit.moveInDirection(SwipeDirection.down, true),
          ),
        },
        child: BlocBuilder<PuzzleCubit, PuzzleCubitState>(
          bloc: widget.puzzleCubit,
          builder: (_, state) => Stack(
            clipBehavior: Clip.none,
            children: [
              ...state.puzzle.mapIndexed((e, i) {
                if (e == 16) return const SizedBox();
                return AnimatedPositioned(
                  key: ValueKey('PuzzleTile-$e'),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  left: i % 4 * tileSize,
                  top: i ~/ 4 * tileSize,
                  child: FxOnActionScale(
                    onTap: () => widget.puzzleCubit.tap(i),
                    onHoverScale: 0.9,
                    onMouseDown: 0.85,
                    child: BlocSelector<PuzzleSeedCubit, PuzzleSeedState, Supershape>(
                      bloc: _puzzleSeedCubit,
                      selector: (state) => state.supershape,
                      builder: (_, supershape) => PuzzleTile(
                        backgroundShape: backgroundShape(supershape),
                        size: tileSize,
                        value: e,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget backgroundShape(Supershape supershape) => AnimatedSupershape(
        key: const ValueKey('bg-shape'),
        duration: const Duration(milliseconds: 1500),
        supershape: supershape,
        color1: Theme.of(context).colorScheme.primary,
        color2: Theme.of(context).colorScheme.primaryContainer,
        size: Size(tileSize, tileSize),
      );
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
