part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();
}

class AddToCartInitial extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartLoading extends AddToCartState {
  final String productId;

  const AddToCartLoading(this.productId);
  @override
  List<Object> get props => [productId];
}

class AddToCartLoaded extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartError extends AddToCartState {
  const AddToCartError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
