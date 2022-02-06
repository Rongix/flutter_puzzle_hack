class PuzzleException implements Exception {
  const PuzzleException([this.message]);

  final String? message;

  factory PuzzleException.invalidCharacters() => const PuzzleExceptionInvalidCharacters();
  factory PuzzleException.wrongSum() => const PuzzleExceptionWrongSum();

  @override
  String toString() {
    return "PuzzleException: $message";
  }
}

class PuzzleExceptionInvalidCharacters extends PuzzleException {
  const PuzzleExceptionInvalidCharacters() : super("Invalid characters, supported values: 1-16 [A-P]");
}

class PuzzleExceptionWrongSum extends PuzzleException {
  const PuzzleExceptionWrongSum()
      : super("Invalid sum of the puzzle, puzzle must contain unique numbers from 1-16");
}
