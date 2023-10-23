import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> checkUserValidation(String phoneNumber);

  Future<AppResponseModel<AuthModel>> login(
      String phoneNumber, String password);

  Future<AppResponseModel<AuthModel>> register(String firstName,
      String lastName, String email, String phoneNumber, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService<Response> _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<bool> checkUserValidation(String phoneNumber) async {
    try {
      final Response response = await _networkService.post(
          endpoint: EndPoints.checkUserValidation, data: {'user': phoneNumber});
      AppResponseModel<bool> responseModel = AppResponseModel<bool>.fromJson(
          response.data, (data) => data['is_exist']);
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel.data;
      }
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<AppResponseModel<AuthModel>> login(
      String phoneNumber, String password) async {
    try {
      final Response response = await _networkService.post(
          endpoint: EndPoints.login,
          data: {'usr': phoneNumber, 'pwd': password});
      return _handleAuthResponse(response);
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<AppResponseModel<AuthModel>> register(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password) async {
    final formData = FormData.fromMap({
      'data': jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile_no': phoneNumber,
        'password': password
      })
    });
    try {
      final Response response = await _networkService.post(
          endpoint: EndPoints.register, data: formData);
      return _handleAuthResponse(response);
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  AppResponseModel<AuthModel> _handleAuthResponse(Response response) {
    AppResponseModel<AuthModel> responseModel = AppResponseModel.fromJson(
        response.data, (data) => AuthModel.fromJson(data));
    if (responseModel.error == 1) {
      throw ServerException(message: responseModel.message);
    } else {
      return responseModel;
    }
  }
}
