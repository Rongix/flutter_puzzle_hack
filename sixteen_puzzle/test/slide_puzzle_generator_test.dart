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
  });
}
