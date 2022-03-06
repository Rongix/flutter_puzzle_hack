import 'package:flutter/painting.dart';

extension PathExt on Path {
  void moveToOffset(Offset offset) => moveTo(offset.dx, offset.dy);
  void lineToOffset(Offset offset) => lineTo(offset.dx, offset.dy);

  Path fromPositions(List<Offset> offsets) {
    final path = Path()..moveToOffset(offsets[0]);
    for (var i = 1; i < offsets.length; i++) {
      path.lineToOffset(offsets[i]);
    }
    return path..close();
  }
}
