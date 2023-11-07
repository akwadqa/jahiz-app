import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notifications/domain/entities/notification.dart';
import 'package:jahiz/features/notifications/domain/usecases/get_notifications.dart';

part 'get_notifictions_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit(this._getNotificationUseCase)
      : super(GetNotificationsInitial());

  final GetNotificationsUseCase _getNotificationUseCase;

  Future<void> getNotifications([int? page]) async {
    emit(GetNotificationsLoading());
    final result = await _getNotificationUseCase(page);
    result.fold(
        (failure) => emit(GetNotificationsFailure(failure.message)),
        (notifications) => notifications.data.isEmpty
            ? emit(GetNotificationsIsEmpty())
            : emit(GetNotificationsSuccess(notifications)));
  }

  Future<bool> onLoadingMore(int? page) async {
    final failureOrLoaded = await _getNotificationUseCase(page);
    return failureOrLoaded.fold((failure) => false,
        (AppResponse<List<Notification>> appResponse) {
      final List<Notification> currentNotifications =
          (state as GetNotificationsSuccess).appResponse.data;
      final List<Notification> newNotifications = appResponse.data;
      currentNotifications.addAll(newNotifications);
      emit(GetNotificationsSuccess((state as GetNotificationsSuccess)
          .appResponse
          .copyWith(
              data: currentNotifications, pagination: appResponse.pagination)));
      return true;
    });
  }
}
