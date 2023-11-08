import 'package:dio/dio.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/profile_details_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDetailsModel> getProfileDetails();

  Future<ProfileDetailsModel> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final NetworkService<Response> _networkService;

  ProfileRemoteDataSourceImpl(this._networkService);

  @override
  Future<ProfileDetailsModel> getProfileDetails() async {
    try {
      final Response response =
          await _networkService.get(endpoint: EndPoints.getProfileDetails);
      return _handleResponse(response);
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Future<ProfileDetailsModel> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled}) async {
    final formData = FormData.fromMap({
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'mobile_no': phone,
      'enabled': enabled
    });
    try {
      final Response response = await _networkService.post(
          endpoint: EndPoints.updateProfileDetails, data: formData);
      return _handleResponse(response);
    } catch (e, stackTrace) {
      throw ServerException(message: e.toString(), stackTrace: stackTrace);
    }
  }

  ProfileDetailsModel _handleResponse(Response<dynamic> response) {
    AppResponseModel<ProfileDetailsModel> responseModel =
        AppResponseModel<ProfileDetailsModel>.fromJson(
            response.data, (data) => ProfileDetailsModel.fromJson(data));
    if (responseModel.error == 1) {
      throw ServerException(message: responseModel.message);
    } else {
      return responseModel.data;
    }
  }
}
