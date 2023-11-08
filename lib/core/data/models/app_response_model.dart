import 'pagination_model.dart';
import '../../error/exception.dart';

import '../../domain/entities/app_response.dart';

class AppResponseModel<T> extends AppResponse<T> {
  const AppResponseModel(
      {required super.statusCode,
      required super.error,
      required super.message,
      required super.pagination,
      required super.data});

  factory AppResponseModel.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    if (json['error'] == 1) {
      throw ServerException(message: json['message']);
    }
    return AppResponseModel<T>(
      statusCode: json['status_code'],
      error: json['error'],
      message: json['message'],
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
      data: create(json['data']),
    );
  }
}
