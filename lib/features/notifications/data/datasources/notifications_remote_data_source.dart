import 'package:dio/dio.dart';
import 'package:jahiz/features/notifications/data/models/notification_model.dart';
import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class NotificationsRemoteDataSource {
  Future<AppResponseModel<List<NotificationModel>>> getNotifications([int? page]);
  Future<AppResponseModel<String>> updateDeviceToken(String deviceToken);
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  final NetworkService<Response> _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<NotificationModel>>> getNotifications([int? page]) async {
    return _getResponse(
      () => _networkService.get(
        endpoint: EndPoints.appMessages,
        queryParameters: {'page': page},
      ),
      (data) => (data as List).map((e) => NotificationModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<AppResponseModel<String>> updateDeviceToken(String deviceToken) async {
    return _getResponse(
      () => _networkService.post(
        endpoint: EndPoints.updateDeviceToken,
        data: {'device_token': deviceToken},
      ),
      (data) => data.toString(),
    );
  }

  Future<AppResponseModel<T>> _getResponse<T>(
    Future<Response> Function() requestFunction,
    T Function(dynamic data) convertFunction,
  ) async {
    final response = await requestFunction();
    if (response.statusCode == 200) {
      AppResponseModel<T> responseModel = AppResponseModel<T>.fromJson(
        response.data,
        convertFunction,
      );
      if (responseModel.error == 1) {
        throw ServerException(message: responseModel.message);
      } else {
        return responseModel;
      }
    } else {
      throw ServerException(message: 'Something went wrong');
    }
  }
}
