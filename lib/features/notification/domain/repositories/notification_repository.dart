import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notification/domain/entities/notification.dart';
import '../../../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, AppResponse<List<Notifications>>>> getNotifications([int? page]);
}
