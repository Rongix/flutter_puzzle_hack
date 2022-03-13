import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SwipeDirection { up, down, left, right, none }

enum PuzzleCompletion { incomplete, complete, unsolvable }

class PuzzleCubit extends Cubit<PuzzleCubitState> {
  PuzzleCubit(List<int> puzzle) : super(PuzzleCubitState.init(puzzle));

  int get blankIndex => state.puzzle.indexOf(16);

  void tap(int listIndex) {
    final x = listIndex % 4;
    final y = listIndex ~/ 4;

    final xBlank = blankIndex % 4;
    final yBlank = blankIndex ~/ 4;

    final puzzleCopy = List<int>.from(state.puzzle);

    if (x != xBlank && y != yBlank) return;

    int getIndex(int x, int y) => (y * 4) + x;
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
    if (x == xBlank) {
      // vertical movement
      final dY = y - yBlank;
      moveNTimes(dY.abs(), 0, dY.sign);
      direction = dY.sign < 0 ? SwipeDirection.down : SwipeDirection.up;
    }
    if (y == yBlank) {
      // horizontal movement
      final dX = x - xBlank;
      moveNTimes(dX.abs(), dX.sign, 0);
      direction = dX.sign < 0 ? SwipeDirection.right : SwipeDirection.left;
    }

    final moveIncrement = state.swipeDirection != direction ? 1 : 0;

    emit(PuzzleCubitState(puzzle: puzzleCopy, moves: state.moves + moveIncrement, swipeDirection: direction));
    // print('$x, $y');
    // print('$xBlank, $yBlank');
  }
}

class PuzzleCubitState extends Equatable {
  const PuzzleCubitState({
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

  @override
  List<Object?> get props => [swipeDirection, moves, puzzle];
}
