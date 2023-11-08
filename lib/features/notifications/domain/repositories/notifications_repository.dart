import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../entities/notification.dart';
import '../../../../core/error/failures.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, AppResponse<List<Notification>>>> getNotifications(
      [int? page]);

  Future<Either<Failure, AppResponse<String>>> updateDeviceToken(
    String deviceToken,
    );
}
