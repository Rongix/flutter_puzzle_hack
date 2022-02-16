import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_exception.dart';
import 'navigator_dataclasses.dart';

class NavigatorCubit extends Cubit<NavigatorCubitState> implements Listenable {
  NavigatorCubit() : super(NavigatorCubitState.init());

  final _listeners = <VoidCallback>[];
  bool get hasListeners => _listeners.isNotEmpty;

  static const homePath = PathTemplate([]);
  static const gamePath = PathTemplate([DynamicSegmentTemplate(param: 'seed')]);
  static const aboutPath = PathTemplate([PathSegmentTemplate(name: 'about')]);

  final pathTemplates = const [homePath, gamePath, aboutPath];

  @override
  void onChange(Change<NavigatorCubitState> change) {
    super.onChange(change);
    if (hasListeners) _listeners.forEach((callback) => callback);
  }

  @override
  void addListener(VoidCallback listener) {
    if (!_listeners.contains(listener)) _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.removeWhere((e) => e == listener);
  }

  NavigatorCubitState parseRouteInformation(String? path) {
    final localPath = path ?? '/';

    late MatchRecord lastRecord;
    final template = pathTemplates.firstWhereOrNull((e) {
      lastRecord = e.match(localPath);
      return lastRecord.isMatch;
    });
    final uri = Uri.tryParse(localPath);

    return NavigatorCubitState(
      uri: uri,
      pathTemplate: template,
      exception: template == null ? NotFoundException(path) : null,
      pathParameters: template == null ? {} : lastRecord.pathParameters,
    );
  }

  void forceUpdateState(NavigatorCubitState state) => emit(state);

  bool canPop() => state.uri?.pathSegments.isNotEmpty ?? false;
}

class NavigatorCubitState extends Equatable {
  const NavigatorCubitState({this.uri, this.pathTemplate, this.exception, this.pathParameters = const {}});
  factory NavigatorCubitState.init() => const NavigatorCubitState();

  /// Currently matched path (does not matter if it is valid or not
  /// because address bar needs to be updated anyways)
  final Uri? uri;
  final PathTemplate? pathTemplate;

  /// If app has a template for a given path, is it valid (e.g)
  /// path with query for a template not expecting a query path is not valid;
  final NavigationException? exception;

  final Map<String, String> pathParameters;

  @override
  List<Object?> get props => [uri, exception];
}

abstract class NavigationException extends AppException {
  const NavigationException(String message) : super(message);
  factory NavigationException.notFound(String path) => NotFoundException(path);
}

class NotFoundException extends NavigationException {
  const NotFoundException(String? path) : super('404: Could not match a given path: $path');
}
