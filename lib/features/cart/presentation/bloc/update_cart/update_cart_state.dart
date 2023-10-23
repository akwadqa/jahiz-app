part of 'update_cart_cubit.dart';

abstract class UpdateCartState extends Equatable {
  const UpdateCartState();
}

class UpdateCartInitial extends UpdateCartState {
  @override
  List<Object> get props => [];
}

class UpdateCartLoading extends UpdateCartState {
  @override
  List<Object> get props => [];
}

class UpdateCartLoaded extends UpdateCartState {
  final Cart cart;
  const UpdateCartLoaded({required this.cart});
  @override
  List<Object> get props => [cart];
}

class UpdateCartEmpty extends UpdateCartState {
  @override
  List<Object> get props => [];
}

class UpdateCartError extends UpdateCartState {
  final String message;
  const UpdateCartError({required this.message});
  @override
  List<Object> get props => [message];
}
