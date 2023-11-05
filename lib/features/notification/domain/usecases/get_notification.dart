import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notification/domain/entities/notification.dart';

import '../../../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class GetNotificationUseCase {
  final NotificationRepository _notificationRepository;

  GetNotificationUseCase(this._notificationRepository);

  Future<Either<Failure, AppResponse<List<Notifications>>>> call([int? page]) async =>
      await _notificationRepository.getNotifications(page);
}
