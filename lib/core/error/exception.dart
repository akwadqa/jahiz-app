import 'dart:developer';

class OfflineException implements Exception {}

class ServerException implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  ServerException({this.message, this.stackTrace}) {
    log(message.toString());
    log(stackTrace.toString());
  }

  @override
  String toString() {
    return message.toString();
  }
}
