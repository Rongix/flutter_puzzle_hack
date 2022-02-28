import 'puzzle_exception.dart';

class SixteenPuzzleGenerator {
  String puzzleToSeed(List<int> val) =>
      String.fromCharCodes(val.map((e) => 64 + e));

  /// Load puzzle from string seed
  /// Seed must contain valid characters raging from ASCII 65 (A) to ASCII 80 (P)
  /// Seed must contain unique characters, ASCII sum == 1160
  /// Can throw [PuzzleExceptionInvalidCharacters] && [PuzzleExceptionWrongSum]
  /// Returns list with values raging from 1 to 16
  List<int> puzzleFromSeed(String seed) {
    final list = seed.codeUnits;
    if (list.any((e) => e > 80 || e < 65))
      throw PuzzleException.invalidCharacters();
    if (list.fold<int>(0, (p, e) => p + e) != 1160)
      throw PuzzleException.wrongSum();
    return list.map((e) => e - 64).toList(growable: false);
  }

  /// Generate valid 4x4 puzzle
  List<int> puzzleRandom() {
    final puzzle = List<int>.generate(16, (i) => i)..shuffle();
    while (!validate(puzzle)) puzzle.shuffle();
    return puzzle;
  }

  /// Check is 16-Puzzle is solvable, total sum of transpositions must be even for the puzzle to be solvable Blank value is 16.
  bool validate(List<int> list) {
    assert(list.length == 16);
    /* Puzzle is solvable when
    a) if the blank is on an even row counting from the bottom  -> number of inversions must be odd.
    b) if the blank is on an odd row counting from the bottom   -> number of inversions is even. */
    final isBlankRowEven = (list.indexOf(16) ~/ 4).isEven;
    final transpositions =
        _countSortTranspositions(List<int>.from(list, growable: false));
    return isBlankRowEven ? transpositions.isOdd : transpositions.isEven;
  }

  int _countSortTranspositions(List<int> list) {
    var transpositions = 0;

    list.sort((a, b) {
      final compare = a.compareTo(b);
      if (compare == 1) transpositions++;
      return compare;
    });
    return transpositions;
  }
}
