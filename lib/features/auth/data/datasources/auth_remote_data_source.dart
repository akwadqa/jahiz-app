import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';

import '../../../../core/data/models/app_response_model.dart';
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

class AuthRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements AuthRemoteDataSource {
  final NetworkService<Response> _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<bool> checkUserValidation(String phoneNumber) async {
    final AppResponseModel<bool> responseModel = await performRequest<bool>(
        () => _networkService.post(
            endpoint: EndPoints.checkUserValidation,
            data: {'user': phoneNumber}),
        (data) => data['is_exist']);
    return responseModel.data;
  }

  @override
  Future<AppResponseModel<AuthModel>> login(
      String phoneNumber, String password) async {
    return await performRequest<AuthModel>(
        () => _networkService.post(
            endpoint: EndPoints.login,
            data: {'usr': phoneNumber, 'pwd': password}),
        (data) => AuthModel.fromJson(data));
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
    return await performRequest<AuthModel>(
        () => _networkService.post(
            endpoint: EndPoints.register, data: formData),
        (data) => AuthModel.fromJson(data));
  }
}
