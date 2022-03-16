import 'package:sixteen_puzzle/src/puzzle_exception.dart';
import 'package:sixteen_puzzle/src/sixteen_puzzle_generator.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  late final SixteenPuzzleGenerator generator;

  setUpAll(() {
    generator = const SixteenPuzzleGenerator();
  });

  group('generator tests', () {
    group('seed', () {
      test('to seed', () {
        final actual = generator.puzzleToSeed(TestData.unsolvablePuzzles.first);
        expect(actual, TestData.unsolvable1Seed);
      });
      test('from seed', () {
        final actual = generator.puzzleFromSeed(TestData.unsolvable1Seed);
        expect(actual, TestData.unsolvable1);
      });

      test('bad seed v1', () {
        final actual = () => generator.puzzleFromSeed(TestData.badSeed1);
        expect(actual, throwsA(isA<PuzzleExceptionWrongSum>()));
      });

      test('bad seed v2', () {
        final actual = () => generator.puzzleFromSeed(TestData.badSeed2);
        expect(actual, throwsA(isA<PuzzleExceptionInvalidCharacters>()));
      });
    });

    test('validator', () {
      for (final puzzle in TestData.unsolvablePuzzles) expect(generator.validate(puzzle), false);
      for (final puzzle in TestData.solvablePuzzles) expect(generator.validate(puzzle), true);
    });

    group('validation logic', () {
      test('counting inversions', () {
        final puzzles = {
          1: <int>[2, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
          10: <int>[1, 8, 2, 9, 4, 3, 7, 6, 5],
          41: <int>[13, 2, 10, 3, 1, 12, 8, 4, 5, 16, 9, 6, 15, 14, 11, 7],
          62: <int>[6, 13, 7, 10, 8, 9, 11, 16, 15, 2, 12, 5, 14, 3, 1, 4],
          56: <int>[3, 9, 1, 15, 14, 11, 4, 6, 13, 16, 10, 12, 2, 7, 8, 5]
        };
        
        for(final puzzle in puzzles.entries)
          expect(generator.countInversions(puzzle.value), puzzle.key);
      });
    });
  });
}
