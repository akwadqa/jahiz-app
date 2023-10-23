part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final Cart cart;
  const CartLoaded({required this.cart});
  @override
  List<Object> get props => [cart];
}

class CartEmpty extends CartState {
  @override
  List<Object> get props => [];
}

class CartError extends CartState {
  final String message;
  const CartError({required this.message});
  @override
  List<Object> get props => [message];
}
