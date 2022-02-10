import 'package:collection/collection.dart';

import 'puzzle_exception.dart';

class SlidePuzzleGenerator {
  String puzzleToSeed(List<int> val) => String.fromCharCodes(val.map((e) => 64 + e));

  /// Load puzzle from string seed
  /// Seed must contain valid characters raging from ASCII 65 (A) to ASCII 80 (P)
  /// Seed must contain unique characters, ASCII sum == 1160
  /// Can throw [PuzzleExceptionInvalidCharacters] && [PuzzleExceptionWrongSum]
  /// Returns list with values raging from 1 to 16
  List<int> puzzleFromSeed(String seed) {
    final list = seed.codeUnits;
    if (list.any((e) => e > 80 || e < 65)) throw PuzzleException.invalidCharacters();
    if (list.sum != 1160) throw PuzzleException.wrongSum();
    return list.map((e) => e - 64).toList(growable: false);
  }

  /// Check is 15-Puzzle is solvable, total sum of transpositions must be even for the puzzle to be solvable
  /// Blank value is 16. Supports only puzzles where blank is the last element.
  /// https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
  /// For puzzle with N = 4 (4 x 4) if N is even, puzzle is solvable if
  /// a) the blank is on an even row counting from the bottom (second-last, fourth-last, etc.)
  /// and number of inversions is odd, or
  /// b) the blank is on an odd row counting from the bottom (last, third-last, fifth-last, etc.)
  /// and number of inversions is even.
  bool validate(List<int> list, [int N = 4]) {
    assert(N * N == list.length);
    final transpositions = _countSortTranspositions(List<int>.from(list));

    if (N.isOdd) return transpositions.isEven;

    if (transpositions.isOdd) return false;
    final blankPosition = list.indexOf(N * N);

    if (blankPosition & 1 == 0) {
      return !(transpositions & 1 == 0);
    } else {
      return transpositions & 1 == 0;
    }
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
