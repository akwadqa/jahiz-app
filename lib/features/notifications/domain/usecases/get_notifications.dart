import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notifications/domain/entities/notification.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository _notificationRepository;

  GetNotificationsUseCase(this._notificationRepository);

  Future<Either<Failure, AppResponse<List<Notification>>>> call(
          [int? page]) async =>
      await _notificationRepository.getNotifications(page);
}
