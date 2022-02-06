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
    if (list.any((e) => e > 80 || e < 65)) throw (PuzzleException.invalidCharacters());
    if (list.sum != 1160) throw (PuzzleException.wrongSum());
    return list.map((e) => e - 64).toList(growable: false);
  }

  /// Check is 15-Puzzle is solvable, total sum of transpositions must be even for the puzzle to be solvable
  /// Blank value is 16. Supports only puzzles where blank is the last element.
  bool validate15(List<int> val) {
    assert(val.last == 16);

    List<int> list = List<int>.from(val, growable: false);
    int transpositions = 0;

    list.sort((a, b) {
      final compare = a.compareTo(b);
      if (compare == 1) transpositions++;
      return compare;
    });
    return transpositions.isEven;
  }
}
