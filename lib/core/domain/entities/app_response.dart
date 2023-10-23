import 'package:equatable/equatable.dart';
import 'package:jahiz/core/domain/entities/pagination.dart';
import 'dart:isolate';

class AppResponse<T> extends Equatable {
  final int statusCode;
  final int error;
  final String message;
  final Pagination? pagination;
  final T data;

  const AppResponse(
      {required this.statusCode,
      required this.error,
      required this.message,
      required this.pagination,
      required this.data});

  AppResponse<T> copyWith({
    int? statusCode,
    int? error,
    String? message,
    Pagination? pagination,
    T? data,
  }) {
    return AppResponse<T>(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      message: message ?? this.message,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [statusCode, error, message, pagination, data];
}

extension Clone<T> on T {
  Future<T> clone() {
    final receive = ReceivePort();
    receive.sendPort.send(this);

    return receive.first.then((e) => e as T).whenComplete(receive.close);
  }
}
