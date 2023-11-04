part of 'place_order_cubit.dart';

abstract class PlaceOrderState extends Equatable {
  const PlaceOrderState();
}

class PlaceOrderInitial extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

class PlaceOrderLoading extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

class PlaceOrderLoaded extends PlaceOrderState {
  final String orderId;

  const PlaceOrderLoaded(this.orderId);
  @override
  List<Object> get props => [orderId];
}

class PlaceOrderError extends PlaceOrderState {
  final String message;
  const PlaceOrderError({required this.message});
  @override
  List<Object> get props => [message];
}
