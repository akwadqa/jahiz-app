import 'package:dio/dio.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/error/exception.dart';

mixin RemoteDataSourceMixin {
  Future<AppResponseModel<T>> performRequest<T>(
      Future<Response> Function() request, T Function(dynamic) fromJson) async {
    try {
      final Response response = await request();
      final AppResponseModel<T> responseModel =
          AppResponseModel<T>.fromJson(response.data, fromJson);
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      }
      return responseModel;
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }
}
