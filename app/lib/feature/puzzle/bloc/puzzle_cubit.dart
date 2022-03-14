import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SwipeDirection { up, down, left, right, none }

enum PuzzleCompletion { incomplete, complete, unsolvable }

class PuzzleCubit extends Cubit<PuzzleCubitState> {
  PuzzleCubit(List<int> puzzle) : super(PuzzleCubitState.init(puzzle));

  int get blankIndex => state.puzzle.indexOf(16);

  int getIndex(int x, int y) => (y * 4) + x;

  /// isFullswipe - all tiles in column/row will be shifted in given direction
  void moveInDirection(SwipeDirection direction, bool isFullswipe) {
    int directionToInt(SwipeDirection direction) {
      switch (direction) {
        case SwipeDirection.up:
          return 1;
        case SwipeDirection.down:
          return -1;
        case SwipeDirection.left:
          return 1;
        case SwipeDirection.right:
          return -1;
        case SwipeDirection.none:
          return 0;
      }
    }

    int maxMoveInDirection(SwipeDirection direction) {
      switch (direction) {
        case SwipeDirection.up:
          return 3 - (blankIndex ~/ 4);
        case SwipeDirection.down:
          return blankIndex ~/ 4;
        case SwipeDirection.left:
          return 3 - (blankIndex % 4);
        case SwipeDirection.right:
          return blankIndex % 4;
        case SwipeDirection.none:
          return 0;
      }
    }

    var axisOffset = directionToInt(direction);
    final max = maxMoveInDirection(direction);
    //Invalid move
    if (max == 0) {
      return;
    }

    if (isFullswipe) axisOffset *= max;

    if (direction == SwipeDirection.up || direction == SwipeDirection.down) {
      final x = blankIndex % 4;
      final y = blankIndex ~/ 4;

      tap(getIndex(x, y + axisOffset));
    }

    if (direction == SwipeDirection.left || direction == SwipeDirection.right) {
      final x = blankIndex % 4;
      final y = blankIndex ~/ 4;

      tap(getIndex(x + axisOffset, y));
    }
  }

  void tap(int listIndex) {
    final x = listIndex % 4;
    final y = listIndex ~/ 4;

    final xBlank = blankIndex % 4;
    final yBlank = blankIndex ~/ 4;

    final puzzleCopy = List<int>.from(state.puzzle);

    if (x != xBlank && y != yBlank) return;
    if (x == xBlank && y == yBlank) return;

    void swapInCopy(int indexA, int indexB) {
      //swap logic
      final temp = puzzleCopy[indexA];
      puzzleCopy[indexA] = puzzleCopy[indexB];
      puzzleCopy[indexB] = temp;
    }

    void moveNTimes(int n, int xIndexModifier, int yIndexModifier) {
      for (var i = 0; i < n; i++) {
        final y = yBlank + (i * yIndexModifier);
        final x = xBlank + (i * xIndexModifier);
        final blankIndex = getIndex(x, y);
        final puzzleIndex = getIndex(x + xIndexModifier, y + yIndexModifier);

        swapInCopy(blankIndex, puzzleIndex);
      }
    }

    late final SwipeDirection direction;
    // vertical movement
    if (x == xBlank) {
      final dY = y - yBlank;
      moveNTimes(dY.abs(), 0, dY.sign);
      direction = dY.sign < 0 ? SwipeDirection.down : SwipeDirection.up;
    }
    // horizontal movement
    if (y == yBlank) {
      final dX = x - xBlank;
      moveNTimes(dX.abs(), dX.sign, 0);
      direction = dX.sign < 0 ? SwipeDirection.right : SwipeDirection.left;
    }

    final moveIncrement = state.swipeDirection != direction ? 1 : 0;

    emit(PuzzleCubitState(puzzle: puzzleCopy, moves: state.moves + moveIncrement, swipeDirection: direction));
  }
}

class PuzzleCubitState extends Equatable {
  PuzzleCubitState({
    this.puzzle = const [],
    this.swipeDirection = SwipeDirection.none,
    this.moves = 0,
  });

  factory PuzzleCubitState.init(List<int> puzzle) => PuzzleCubitState(
        puzzle: puzzle,
      );

  final SwipeDirection swipeDirection;
  final int moves;
  final List<int> puzzle;

  late final bool isCompleted = _computeIsCompleted();
  late final bool isFreshPuzzle = _computeIsFreshPuzzle();

  bool _computeIsFreshPuzzle() => moves == 0;
  bool _computeIsCompleted() {
    for (var i = 0; i < puzzle.length; i++) if (puzzle[i] != i + 1) return false;
    return true;
  }

  @override
  List<Object?> get props => [swipeDirection, moves, puzzle];
}
