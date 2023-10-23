part of 'add_detailed_product_to_cart_cubit.dart';

abstract class AddDetailedProductToCartState extends Equatable {
  const AddDetailedProductToCartState();
}

class AddDetailedProductToCartInitial extends AddDetailedProductToCartState {
  @override
  List<Object> get props => [];
}

class AddDetailedProductToCartLoading extends AddDetailedProductToCartState {
  @override
  List<Object> get props => [];
}

class AddDetailedProductToCartLoaded extends AddDetailedProductToCartState {
  @override
  List<Object> get props => [];
}

class AddDetailedProductToCartError extends AddDetailedProductToCartState {
  const AddDetailedProductToCartError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
