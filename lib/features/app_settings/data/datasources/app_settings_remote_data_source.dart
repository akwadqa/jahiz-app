import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../models/app_settings_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class AppSettingsRemoteDataSource {
  Future<AppSettingsModel> getAppSettings();
}

class AppSettingsRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements AppSettingsRemoteDataSource {
  final NetworkService<Response> _networkService;

  AppSettingsRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppSettingsModel> getAppSettings() async {
    final AppResponseModel<AppSettingsModel> responseModel =
        await performRequest<AppSettingsModel>(
            () =>
               _networkService.get(endpoint: EndPoints.getAppSettings),
            (data) => AppSettingsModel.fromJson(data));
    return responseModel.data;
  }
}
