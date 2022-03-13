import 'package:app/feature/core/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixteen_puzzle/slide_puzzle.dart';

class PuzzleSeedException extends AppException {
  PuzzleSeedException._(String message) : super(message);

  factory PuzzleSeedException.invalidSeed() => PuzzleSeedException._('Invalid seed, could not load puzzle');
}

/// *Singleton (registered in getIt)
class PuzzleSeedCubit extends Cubit<PuzzleSeedState> {
  PuzzleSeedCubit(this.generator)
      : super(PuzzleSeedState(seed: solvedSeed, puzzle: solvedPuzzle, isSolvable: true));

  final SixteenPuzzleGenerator generator;

  static const String solvedSeed = 'ABCDEFGHIJKLMNOP';
  static List<int> get solvedPuzzle => List<int>.generate(17, (i) => i + 1);

  void randomSeed() {
    final solvablePuzzle = generator.puzzleRandom();
    final solvableSeed = generator.puzzleToSeed(solvablePuzzle);

    return emit(PuzzleSeedState(seed: solvableSeed, puzzle: solvablePuzzle, isSolvable: true));
  }

  void fromSeed(String seed) {
    try {
      final puzzle = generator.puzzleFromSeed(seed);
      return emit(PuzzleSeedState(
        seed: seed,
        puzzle: puzzle,
        isSolvable: generator.validate(puzzle),
      ));
    } on PuzzleException {
      return emit(PuzzleSeedState(
        seed: seed,
        puzzle: const [],
        isSolvable: false,
        appException: PuzzleSeedException.invalidSeed(),
      ));
    }
  }
}

class PuzzleSeedState extends Equatable {
  const PuzzleSeedState({
    required this.seed,
    required this.puzzle,
    required this.isSolvable,
    this.appException,
  });

  final String seed;
  final List<int> puzzle;
  final bool isSolvable;
  final AppException? appException;

  @override
  List<Object?> get props => [seed, puzzle, isSolvable, appException];
}
