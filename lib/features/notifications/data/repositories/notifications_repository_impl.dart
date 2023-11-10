import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../datasources/notifications_remote_data_source.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class NotificationsRepositoryImpl extends NetworkOperationHandler
    implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepositoryImpl(this.remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<Notification>>>> getNotifications(
      [int? page]) async {
    return await handleNetworkOperation(() async {
      final response = await remoteDataSource.getNotifications(page);
      return response;
    });
  }

  @override
  Future<Either<Failure, AppResponse<String>>> updateDeviceToken(
    String deviceToken,
  ) async {
    return await handleNetworkOperation(() {
      return remoteDataSource.updateDeviceToken(
        deviceToken,
      );
    });
  }
}
