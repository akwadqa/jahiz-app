part of 'get_notifictions_cubit.dart';

sealed class GetNotificationsState extends Equatable {
  const GetNotificationsState();

  @override
  List<Object> get props => [];
}

final class GetNotificationsInitial extends GetNotificationsState {}

final class GetNotificationsLoading extends GetNotificationsState {}

final class GetNotificationsIsEmpty extends GetNotificationsState {}

final class GetNotificationsSuccess extends GetNotificationsState {
  final AppResponse<List<Notification>> appResponse;
  const GetNotificationsSuccess(this.appResponse);
}

final class GetNotificationsFailure extends GetNotificationsState {
  final String error;
  const GetNotificationsFailure(this.error);
}
