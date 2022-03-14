import 'package:app/feature/core/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

import '../supershape/supershape.dart';

class PuzzleSeedException extends AppException {
  PuzzleSeedException._(String message) : super(message);

  factory PuzzleSeedException.invalidSeed() => PuzzleSeedException._('Invalid seed, could not load puzzle');
}

/// *Singleton (registered in getIt)
/// Puzzle Seed controlls current seed in literal form -> String
/// and generated List<int>.
/// In addition seed directly controls generated shapes in the puzzle
class PuzzleSeedCubit extends Cubit<PuzzleSeedState> {
  PuzzleSeedCubit(this.generator) : super(solvedState);

  final SixteenPuzzleGenerator generator;

  static const String solvedSeed = 'ABCDEFGHIJKLMNOP';
  static List<int> get solvedPuzzle => List<int>.generate(16, (i) => i + 1);

  static PuzzleSeedState get solvedState => PuzzleSeedState(
        seed: solvedSeed,
        puzzle: solvedPuzzle,
        isSolvable: true,
        supershape: Supershape.fromSeed(seed: solvedSeed),
      );

  /// Generate random but solvable seed
  void randomSeed() {
    final puzzle = generator.puzzleRandom();
    final puzzleSeed = generator.puzzleToSeed(puzzle);

    return emit(PuzzleSeedState(
        seed: puzzleSeed,
        puzzle: puzzle,
        isSolvable: true,
        supershape: Supershape.fromSeed(seed: puzzleSeed)));
  }

  /// Provided seed by e.g: browser can be faulty / unsolvable. Return solved puzzle in this case.
  void fromSeed(String seed) {
    if (seed == state.seed) return;

    try {
      final puzzle = generator.puzzleFromSeed(seed);
      return emit(PuzzleSeedState(
        seed: seed,
        puzzle: puzzle,
        isSolvable: generator.validate(puzzle),
        supershape: Supershape.fromSeed(seed: seed),
      ));
    } on PuzzleException {
      return emit(PuzzleSeedState(
        seed: seed,
        appException: PuzzleSeedException.invalidSeed(),
        puzzle: state.puzzle,
        supershape: state.supershape,
        isSolvable: true,
      ));
    }
  }
}

class PuzzleSeedState extends Equatable {
  const PuzzleSeedState({
    required this.seed,
    required this.puzzle,
    required this.isSolvable,
    required this.supershape,
    this.appException,
  });

  final String seed;
  final List<int> puzzle;
  final Supershape supershape;
  final bool isSolvable;
  final AppException? appException;

  @override
  List<Object?> get props => [seed, puzzle, isSolvable, appException];
}
