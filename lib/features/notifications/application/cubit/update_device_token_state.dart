part of 'update_device_token_cubit.dart';

sealed class UpdateDeviceTokenState extends Equatable {
  const UpdateDeviceTokenState();

  @override
  List<Object> get props => [];
}

final class UpdateDeviceTokenInitial extends UpdateDeviceTokenState {}

final class UpdateDeviceTokenLoading extends UpdateDeviceTokenState {}

final class UpdateDeviceTokenSuccess extends UpdateDeviceTokenState {}

final class UpdateDeviceTokenFailure extends UpdateDeviceTokenState {
  final String message;

  const UpdateDeviceTokenFailure(this.message);

  @override
  List<Object> get props => [message];
}
