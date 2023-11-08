import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/app_response.dart';
import '../entities/notification.dart';
import '../../../../core/error/failures.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase {
  final NotificationsRepository _notificationRepository;

  GetNotificationsUseCase(this._notificationRepository);

  Future<Either<Failure, AppResponse<List<Notification>>>> call(
          [int? page]) async =>
      await _notificationRepository.getNotifications(page);
}
