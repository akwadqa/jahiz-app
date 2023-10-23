part of 'payment_methods_cubit.dart';

abstract class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsLoading extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsLoaded extends PaymentMethodsState {
  final List<PaymentMethod> paymentMethods;

  const PaymentMethodsLoaded(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

class PaymentMethodsError extends PaymentMethodsState {
  final String message;

  const PaymentMethodsError(this.message);

  @override
  List<Object> get props => [message];
}
