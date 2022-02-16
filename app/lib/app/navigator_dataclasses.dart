import 'package:equatable/equatable.dart';

abstract class SegmentTemplate extends Equatable {
  const SegmentTemplate({required this.template});
  factory SegmentTemplate.path(String name) => PathSegmentTemplate(name: name);
  factory SegmentTemplate.template(String name) => PathSegmentTemplate(name: name);

  final String template;

  bool get isPath => this is PathSegmentTemplate;
  bool get isDynamic => this is DynamicSegmentTemplate;

  PathSegmentTemplate get asPath => this as PathSegmentTemplate;
  DynamicSegmentTemplate get asDynamic => this as DynamicSegmentTemplate;

  MatchEntry match(String segment) {
    if (isDynamic) return MatchEntry(isMatch: true, pathParameter: MapEntry(template, segment));
    return MatchEntry(isMatch: segment == template);
  }

  @override
  List<Object?> get props => [template];
}

class PathSegmentTemplate extends SegmentTemplate {
  const PathSegmentTemplate({required String name}) : super(template: name);
}

class DynamicSegmentTemplate extends SegmentTemplate {
  const DynamicSegmentTemplate({required String param}) : super(template: param);
}

class PathTemplate extends Equatable {
  const PathTemplate(this.segments);

  final List<SegmentTemplate> segments;

  String get template => '/${segments.map((e) => e.template).join('/')}';
  Set<String> get requiredPathParams {
    return segments.fold<Set<String>>({}, (p, e) => e is DynamicSegmentTemplate ? (p..add(e.template)) : p);
  }

  String expand(Map<String, String> pathParams) {
    return '/${segments.map((e) => e.isDynamic ? pathParams[e.template] : e.template).join('/')}';
  }

  bool get hasDynamicSegments => segments.any((e) => e.isDynamic);

  MatchRecord match(String path) {
    if (!hasDynamicSegments) return MatchRecord(isMatch: path == template);

    final pathSegments = path.trimIfFirst('/').split('/');
    final pathParameters = <MapEntry<String, String>>[];
    if (pathSegments.length != segments.length) return const MatchRecord(isMatch: false);

    for (var i = 0; i < segments.length; i++) {
      final match = segments[i].match(pathSegments[i]);
      if (!match.isMatch) return const MatchRecord(isMatch: false);
      if (match.pathParameter != null) pathParameters.add(match.pathParameter!);
    }
    return MatchRecord(isMatch: true, pathParameters: Map.fromEntries(pathParameters));
  }

  @override
  List<Object?> get props => [segments, template];
}

extension on String {
  String trimIfFirst(String char) {
    if (isEmpty) return this;
    return this[0] == char ? substring(1) : this;
  }
}

class MatchRecord extends Equatable {
  const MatchRecord({required this.isMatch, this.pathParameters = const {}});

  final Map<String, String> pathParameters;
  final bool isMatch;

  @override
  List<Object?> get props => [];
}

class MatchEntry extends Equatable {
  const MatchEntry({required this.isMatch, this.pathParameter});

  final bool isMatch;
  final MapEntry<String, String>? pathParameter;

  @override
  List<Object?> get props => [pathParameter, isMatch];
}
