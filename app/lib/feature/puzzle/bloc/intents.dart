import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class MoveIntent extends Intent {}

class MoveRightIntent extends MoveIntent {}

class MoveLeftIntent extends MoveIntent {}

class MoveUpIntent extends MoveIntent {}

class MoveDownIntent extends MoveIntent {}

class SwipeRightIntent extends MoveIntent {}

class SwipeLeftIntent extends MoveIntent {}

class SwipeUpIntent extends MoveIntent {}

class SwipeDownIntent extends MoveIntent {}

final moveRightKeySet = LogicalKeySet(LogicalKeyboardKey.arrowRight);
final moveLeftKeySet = LogicalKeySet(LogicalKeyboardKey.arrowLeft);
final moveUpKeySet = LogicalKeySet(LogicalKeyboardKey.arrowUp);
final moveDownKeySet = LogicalKeySet(LogicalKeyboardKey.arrowDown);

final moveRightKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyD);
final moveLeftKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyA);
final moveUpKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyW);
final moveDownKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyS);

final swipeRightKeySet = LogicalKeySet(LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.shift);
final swipeLeftKeySet = LogicalKeySet(LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.shift);
final swipeUpKeySet = LogicalKeySet(LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.shift);
final swipeDownKeySet = LogicalKeySet(LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.shift);

final swipeRightKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyD, LogicalKeyboardKey.shift);
final swipeLeftKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.shift);
final swipeUpKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyW, LogicalKeyboardKey.shift);
final swipeDownKeyV2Set = LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.shift);
