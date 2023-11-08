import 'package:dio/dio.dart';
import '../models/address_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';
import '../models/city_model.dart';

abstract class AddressesRemoteDataSource {
  Future<AppResponseModel<List<CityModel>>> getCities();
  Future<AppResponseModel<AddressModel>> addUpdateAddress(
      {required AddressModel addressModel});
  Future<AppResponseModel<List<AddressModel>>> getAddresses();
}

class AddressesRemoteDataSourceImpl implements AddressesRemoteDataSource {
  final NetworkService<Response> _networkService;

  AddressesRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<CityModel>>> getCities() async {
    try {
      final Response response =
          await _networkService.get(endpoint: EndPoints.getCities);
      if (response.statusCode == 200) {
        AppResponseModel<List<CityModel>> responseModel =
            AppResponseModel<List<CityModel>>.fromJson(
                response.data,
                (data) =>
                    (data as List).map((e) => CityModel.fromJson(e)).toList());
        if (responseModel.error == 1) {
          throw ServerException(message: responseModel.message);
        } else {
          return responseModel;
        }
      } else {
        throw ServerException(message: 'Something went wrong');
      }
    } on ServerException catch (e, stackTrace) {
      throw ServerException(message: e.message ?? '', stackTrace: stackTrace);
    }
  }

  @override
  Future<AppResponseModel<AddressModel>> addUpdateAddress(
      {required AddressModel addressModel}) async {
    try {
      final Response response = await _networkService.post(
          endpoint: EndPoints.addUpdateAddress, data: addressModel.toJson());
      if (response.statusCode == 200) {
        AppResponseModel<AddressModel> responseModel =
            AppResponseModel<AddressModel>.fromJson(
                response.data, (data) => AddressModel.fromJson(data));
        if (responseModel.error == 1) {
          throw ServerException(message: responseModel.message);
        } else {
          return responseModel;
        }
      } else {
        throw ServerException(message: 'Something went wrong');
      }
    } on ServerException catch (e, stackTrace) {
      throw ServerException(message: e.message ?? '', stackTrace: stackTrace);
    }
  }

  @override
  Future<AppResponseModel<List<AddressModel>>> getAddresses() async {
    try {
      final Response response =
          await _networkService.get(endpoint: EndPoints.getAddresses);
      if (response.statusCode == 200) {
        AppResponseModel<List<AddressModel>> responseList =
            AppResponseModel<List<AddressModel>>.fromJson(
                response.data,
                (data) => (data as List)
                    .map((e) => AddressModel.fromJson(e))
                    .toList());
        if (responseList.error == 1) {
          throw ServerException(message: responseList.message);
        } else {
          return responseList;
        }
      } else {
        throw ServerException(message: 'Something went wrong');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message ?? '', stackTrace: e.stackTrace);
    }
  }
}
