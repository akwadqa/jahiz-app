part of 'create_order_cubit.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();
}

class CreateOrderInitial extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class CreateOrderLoading extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class CreateOrderLoaded extends CreateOrderState {
  final Order order;

  const CreateOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class CreateOrderError extends CreateOrderState {
  final String message;
  const CreateOrderError({required this.message});
  @override
  List<Object> get props => [message];
}
