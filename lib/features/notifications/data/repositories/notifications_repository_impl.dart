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
  final NetworkInfo _networkInfo;

  NotificationsRepositoryImpl(this.remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AppResponse<List<Notification>>>> getNotifications(
      [int? page]) async {
    if (await _networkInfo.isConnected) {
      try {
        final AppResponse<List<Notification>> response =
            await remoteDataSource.getNotifications(page);
        return Right(response);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
