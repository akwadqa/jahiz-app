part of 'update_payment_status_cubit.dart';

abstract class UpdatePaymentStatusState extends Equatable {
  const UpdatePaymentStatusState();
}

class UpdatePaymentStatusInitial extends UpdatePaymentStatusState {
  @override
  List<Object> get props => [];
}

class UpdatePaymentStatusLoading extends UpdatePaymentStatusState {
  @override
  List<Object> get props => [];
}

class UpdatePaymentStatusLoaded extends UpdatePaymentStatusState {
  const UpdatePaymentStatusLoaded();
  @override
  List<Object> get props => [];
}

class UpdatePaymentStatusError extends UpdatePaymentStatusState {
  final String message;
  const UpdatePaymentStatusError({required this.message});
  @override
  List<Object> get props => [message];
}
