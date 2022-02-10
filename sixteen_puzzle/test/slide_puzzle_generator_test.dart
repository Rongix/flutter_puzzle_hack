import 'package:flutter_test/flutter_test.dart';
import 'package:sixteen_puzzle/src/puzzle_exception.dart';
import 'package:sixteen_puzzle/src/slide_puzzle_generator.dart';

import 'test_data.dart';

void main() {
  late final SlidePuzzleGenerator generator;

  setUp(() {
    generator = SlidePuzzleGenerator();
  });

  group('generator tests', () {
    group('seed', () {
      test('to seed', () {
        final actual = generator.puzzleToSeed(TestData.unsolvable1);
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
      expect(generator.validate(TestData.unsolvable1), false);
      expect(generator.validate(TestData.unsolvable2), false);

      expect(generator.validate(TestData.solvable1), true);
      expect(generator.validate(TestData.solvable2), true);
    });
  });
}
