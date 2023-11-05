import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/notification/domain/entities/notification.dart';
import 'package:jahiz/features/notification/domain/usecases/get_notification.dart';

part 'get_notifictions_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  GetNotificationsCubit(this._getNotificationUseCase) : super(GetNotificationsInitial());

   final GetNotificationUseCase _getNotificationUseCase;

  Future<void> getNotifications([int? page]) async {
    emit(GetNotificationsLoading());
    final result = await _getNotificationUseCase(page);
    result.fold(
        (failure) => emit(GetNotificationsFailure(failure.message)),
        (notifications) => notifications.data.isEmpty ? emit(GetNotificationsIsEmpty()) : emit(GetNotificationsSuccess(notifications)));
  }

    Future<bool> onLoadingMore(int? page) async {
    final failureOrLoaded = await _getNotificationUseCase(page);
    return failureOrLoaded.fold((failure) => false,
        (AppResponse<List<Notifications>> appResponse) {
      final List<Notifications> currentNotifications =
          (state as GetNotificationsSuccess).appResponse.data;
      final List<Notifications> newNotifications = appResponse.data;
      currentNotifications.addAll(newNotifications);
      emit(GetNotificationsSuccess((state as GetNotificationsSuccess)
          .appResponse
          .copyWith(
              data: currentNotifications, pagination: appResponse.pagination)));
      return true;
    });
  }
}