import 'dart:developer';

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;
}

class OfflineFailure extends Failure {
  @override
  String get message => 'You\'re offline';

  @override
  List<Object?> get props => [];

  @override
  toString() => message;
}

class ServerFailure extends Failure {
  final String _message;
  final StackTrace _stackTrace;
  ServerFailure(this._message, this._stackTrace) {
    log(_message);
    log(_stackTrace.toString());
  }

  @override
  String get message => _message;

  @override
  List<Object?> get props => [_message, _stackTrace];

  @override
  toString() => message;
}
