import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/notifications/domain/repositories/notifications_repository.dart';

class UpdateDeviceTokenUseCase {
  final NotificationsRepository _notificationRepository;

  UpdateDeviceTokenUseCase(this._notificationRepository);

  Future<Either<Failure, AppResponse<String>>> call({
    required String deviceToken,
  }) async {
    return await _notificationRepository.updateDeviceToken(
      deviceToken,
    );
  }
}
