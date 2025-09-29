import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../../../../cart/application/cart_service.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/product.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addToCart(Product product) async {
    emit(AddToCartLoading(product.productId));
    final failureOrCart =
        await getIt<CartService>().addToCart(product: product, quantity: 1);
    if (getIt<bool>()) {
      // Vibrate.feedback(FeedbackType.light);
    }
    return failureOrCart.fold(
        (failure) => emit(AddToCartError(message: failure.message)),
        (cart) => emit(AddToCartLoaded()));
  }
}
