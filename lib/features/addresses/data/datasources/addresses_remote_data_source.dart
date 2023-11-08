import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../models/address_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class AddressesRemoteDataSource {
  Future<AppResponseModel<AddressModel>> addUpdateAddress(
      {required AddressModel addressModel});
  Future<AppResponseModel<List<AddressModel>>> getAddresses();
}

class AddressesRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements AddressesRemoteDataSource {
  final NetworkService<Response> _networkService;

  AddressesRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<AddressModel>> addUpdateAddress(
      {required AddressModel addressModel}) async {
    return await performRequest<AddressModel>(
        () => _networkService.post(
            endpoint: EndPoints.addUpdateAddress, data: addressModel.toJson()),
        (data) => AddressModel.fromJson(data));
  }

  @override
  Future<AppResponseModel<List<AddressModel>>> getAddresses() async {
    return await performRequest<List<AddressModel>>(
        () => _networkService.get(endpoint: EndPoints.getAddresses),
        (data) => (data as List).map((e) => AddressModel.fromJson(e)).toList());
  }
}
