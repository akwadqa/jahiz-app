import 'package:dio/dio.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/error/exception.dart';
import 'package:jahiz/core/network/end_points.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/features/cities/data/models/city_model.dart';

abstract class CitiesRemoteDataSource {
  Future<AppResponseModel<List<CityModel>>> getCities();
}

class CitiesRemoteDataSourceImpl implements CitiesRemoteDataSource {
  final NetworkService<Response> _networkService;

  CitiesRemoteDataSourceImpl(this._networkService);

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
  }