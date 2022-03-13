abstract class PuzzleException implements Exception {
  const PuzzleException(this.message);

  factory PuzzleException.invalidCharacters() => const PuzzleExceptionInvalidCharacters();
  factory PuzzleException.wrongSum() => const PuzzleExceptionWrongSum();

  final String message;

  @override
  String toString() => 'PuzzleException: $message';
}

/// Invalid characters, supported values: 1-16 [A-P]
class PuzzleExceptionInvalidCharacters extends PuzzleException {
  const PuzzleExceptionInvalidCharacters() : super('Invalid characters, supported values: 1-16 [A-P]');
}

/// Invalid sum of the puzzle, puzzle must contain unique numbers from 1-16
class PuzzleExceptionWrongSum extends PuzzleException {
  const PuzzleExceptionWrongSum()
      : super('Invalid sum of the puzzle, puzzle must contain unique numbers from 1-16');
}
