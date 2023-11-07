import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:jahiz/features/notifications/domain/entities/notification.dart';
import 'package:jahiz/features/notifications/domain/repositories/notifications_repository.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NotificationsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<Notification>>>> getNotifications(
      [int? page]) async {
    return await _performNetworkOperation(
        () => remoteDataSource.getNotifications(page));
  }

  @override
  Future<Either<Failure, AppResponse<String>>> updateDeviceToken(
    String deviceToken,
  ) async {
    return await _performNetworkOperation(
        () => remoteDataSource.updateDeviceToken(
              deviceToken,
            ));
  }

  Future<Either<Failure, T>> _performNetworkOperation<T>(
      Future<T> Function() operation) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await operation();
        return Right(response);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Future.value(Left(OfflineFailure()));
    }
  }
}
