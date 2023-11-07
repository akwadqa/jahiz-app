import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/cart/application/cart_service.dart';
import 'package:jahiz/injection_container.dart';
import '../../../domain/entities/product.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addToCart(Product product) async {
    emit(AddToCartLoading());
    final failureOrCart =
        await getIt<CartService>().addToCart(product: product, quantity: 1);
    return failureOrCart.fold(
        (failure) => emit(AddToCartError(message: failure.message)),
        (cart) => emit(AddToCartLoaded()));
  }
}
