import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  const AppException(this.message);

  final String? message;

  @override
  String toString() => 'App error: $message';

  @override
  List<Object?> get props => [];
}
