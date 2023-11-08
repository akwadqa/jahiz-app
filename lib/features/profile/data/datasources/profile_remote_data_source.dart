import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../../../../core/data/models/app_response_model.dart';
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

class ProfileRemoteDataSourceImpl with RemoteDataSourceMixin implements ProfileRemoteDataSource {
  final NetworkService<Response> _networkService;

  ProfileRemoteDataSourceImpl(this._networkService);

  @override
  Future<ProfileDetailsModel> getProfileDetails() async {
    final AppResponseModel<ProfileDetailsModel> responseModel =
        await performRequest<ProfileDetailsModel>(
            () => _networkService.get(endpoint: EndPoints.getProfileDetails),
            (data) => ProfileDetailsModel.fromJson(data));
    return responseModel.data;
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
    final AppResponseModel<ProfileDetailsModel> responseModel =
        await performRequest<ProfileDetailsModel>(
            () => _networkService.post(
                endpoint: EndPoints.updateProfileDetails, data: formData),
            (data) => ProfileDetailsModel.fromJson(data));
    return responseModel.data;
  }
}
