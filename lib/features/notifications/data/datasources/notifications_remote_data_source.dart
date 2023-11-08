import 'package:dio/dio.dart';
import 'package:jahiz/core/network/remote_data_source_mixin.dart';
import '../models/notification_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class NotificationsRemoteDataSource {
  Future<AppResponseModel<List<NotificationModel>>> getNotifications(
      [int? page]);
  Future<AppResponseModel<String>> updateDeviceToken(String deviceToken);
}

class NotificationsRemoteDataSourceImpl
    with RemoteDataSourceMixin
    implements NotificationsRemoteDataSource {
  final NetworkService<Response> _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<NotificationModel>>> getNotifications(
      [int? page]) async {
    return performRequest<List<NotificationModel>>(
        () => _networkService.get(
              endpoint: EndPoints.appMessages,
              queryParameters: {'page': page},
            ),
        (data) =>
            (data as List).map((e) => NotificationModel.fromJson(e)).toList());
  }

  @override
  Future<AppResponseModel<String>> updateDeviceToken(String deviceToken) async {
    return performRequest<String>(
        () => _networkService.post(
              endpoint: EndPoints.updateDeviceToken,
              data: {'device_token': deviceToken},
            ),
        (data) => data.toString());
  }
}
