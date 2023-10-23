import 'package:dio/dio.dart';
import 'package:jahiz/features/app_settings/data/models/app_settings_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class AppSettingsRemoteDataSource {
  Future<AppSettingsModel> getAppSettings();
}

class AppSettingsRemoteDataSourceImpl implements AppSettingsRemoteDataSource {
  final NetworkService<Response> _networkService;

  AppSettingsRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppSettingsModel> getAppSettings() async {
    try {
      final response =
          await _networkService.get(endpoint: EndPoints.getAppSettings);
      if (response.statusCode == 200) {
        AppResponseModel<AppSettingsModel> responseModel =
            AppResponseModel<AppSettingsModel>.fromJson(
                response.data, (data) => AppSettingsModel.fromJson(data));
        if (responseModel.error == 1) {
          throw ServerException(message: responseModel.message);
        } else {
          return responseModel.data;
        }
      } else {
        throw ServerException(message: 'Something went wrong');
      }
    } on ServerException catch (e, stackTrace) {
      throw ServerException(message: e.message ?? '', stackTrace: stackTrace);
    }
  }
}
