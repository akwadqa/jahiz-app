import 'package:dio/dio.dart';
import 'package:jahiz/features/notification/data/models/notifications_model.dart';

import '../../../../core/data/models/app_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/network_service.dart';

abstract class NotificationsRemoteDataSource {
  Future<AppResponseModel<List<NotificationModel>>> getNotifications(
      [int? page]);
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NetworkService<Response> _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<AppResponseModel<List<NotificationModel>>> getNotifications(
      [int? page]) async {
    try {
      final Response response = await _networkService.get(
        endpoint: EndPoints.getNotifications,
        queryParameters: {
          'page': page,
        },
      );
      if (response.statusCode == 200) {
        AppResponseModel<List<NotificationModel>> responseList =
            AppResponseModel<List<NotificationModel>>.fromJson(
                response.data,
                (data) => (data as List)
                    .map((e) => NotificationModel.fromJson(e))
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
