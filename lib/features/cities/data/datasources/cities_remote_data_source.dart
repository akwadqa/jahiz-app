import 'package:dio/dio.dart';
import 'package:jahiz/core/data/models/app_response_model.dart';
import 'package:jahiz/core/network/end_points.dart';
import 'package:jahiz/core/network/network_service.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import 'package:jahiz/features/cities/data/models/city_model.dart';

abstract class CitiesRemoteDataSource {
  Future<AppResponseModel<List<CityModel>>> getCities();
}

class CitiesRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements CitiesRemoteDataSource {
  final NetworkService<Response> _networkService;

  CitiesRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<CityModel>>> getCities() async {
    return await performRequest<List<CityModel>>(
        () => _networkService.get(endpoint: EndPoints.getCities),
        (data) => (data as List).map((e) => CityModel.fromJson(e)).toList());
  }
}
