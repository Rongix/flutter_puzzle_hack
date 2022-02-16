import 'package:app/app/navigator_dataclasses.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const path1 = PathTemplate([]);
  const path2 = PathTemplate([
    PathSegmentTemplate(name: 'game'),
    DynamicSegmentTemplate(param: 'id'),
  ]);
  const path3 = PathTemplate([
    PathSegmentTemplate(name: 'hello'),
    PathSegmentTemplate(name: 'there'),
  ]);

  test('path template returns correct representation', () {
    expect(path1.template, '/');
    expect(path2.template, '/game/id');
    expect(path3.template, '/hello/there');
  });

  test('path template expansion', () {
    expect(path1.expand({}), '/');
    expect(path2.expand({'id': '20'}), '/game/20');
    expect(path2.expand({}), '/game/null');
    expect(path3.expand({'there': 'lol'}), '/hello/there');
  });

  test('path matches template', () {
    expect(path1.match('/'), const MatchRecord(isMatch: true));
    expect(path1.match('/ok'), const MatchRecord(isMatch: false));

    expect(path2.match('/game/lol'), const MatchRecord(isMatch: true, pathParameters: {'id': 'lol'}));
    expect(path2.match('/game/lol/ok'), const MatchRecord(isMatch: false));

    expect(path3.match('/hello/there'), const MatchRecord(isMatch: true));
    expect(path3.match('/game/ther'), const MatchRecord(isMatch: false));
  });
}
