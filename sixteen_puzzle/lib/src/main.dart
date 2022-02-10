import 'package:sixteen_puzzle/src/slide_puzzle_generator.dart';

void main() {
  final generator = SixteenPuzzleGenerator();
  for (var i = 0; i < 8; i++) print(generator.puzzleRandom());
}
