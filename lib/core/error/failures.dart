import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// General failures

class ServerFailure extends Failure {
  const ServerFailure({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
