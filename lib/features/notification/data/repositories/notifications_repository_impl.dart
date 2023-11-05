import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:jahiz/features/notification/domain/entities/notification.dart';
import 'package:jahiz/features/notification/domain/repositories/notification_repository.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<Notifications>>>> getNotifications([int? page]) async {
    if (await _networkInfo.isConnected) {
      try {
        final AppResponse<List<Notifications>> response = await remoteDataSource.getNotifications(page);
        return Right(response);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
