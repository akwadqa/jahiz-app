import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notifications/domain/entities/notification.dart';
import '../../../../core/error/failures.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, AppResponse<List<Notification>>>> getNotifications(
      [int? page]);
}
