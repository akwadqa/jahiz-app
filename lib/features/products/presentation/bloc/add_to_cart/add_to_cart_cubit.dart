import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../cart/domain/entities/cart.dart';
import '../../../../cart/domain/entities/cart_item.dart';
import '../../../../cart/domain/usecases/get_cart.dart';
import '../../../../cart/domain/usecases/update_cart.dart';
import '../../../domain/entities/product.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit(this._getCartUseCase, this._updateCartUseCase)
      : super(AddToCartInitial());

  final GetCartUseCase _getCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;

  Future<void> addToCart(Product product) async {
    emit(AddToCartLoading());
    final failureOrCart = await _getCartUseCase();
    return failureOrCart
        .fold((failure) => emit(AddToCartError(message: failure.message)),
            (cart) async {
      if (cart != null) {
        if (cart.items
            .any((element) => element.itemCode == product.productId)) {
          final productItem = cart.items
              .firstWhere((element) => element.itemCode == product.productId);
          final CartItem cartItem =
              productItem.copyWith(qty: productItem.qty + 1);
          cart.items
              .removeWhere((element) => element.itemCode == product.productId);
          cart.items.add(cartItem.toModel());
        } else {
          cart.items.add(product.toCartItem().copyWith(qty: 1).toModel());
        }
      } else {
        cart = Cart(
            items: [product.toCartItem().copyWith(qty: 1).toModel()],
            name: '',
            transactionDate: '',
            shippingAddressName: '',
            currency: '',
            totalQty: 0,
            totalTaxesAndCharges: 0,
            additionalDiscountPercentage: 0,
            discountAmount: 0,
            grandTotal: 0,
            status: '',
            couponCode: '',
            couponCodeDetails: null,
            shippingAddressDetails: const [],
            otherChargesCalculation: const []);
      }
      final failureOrCart = await _updateCartUseCase(cart);
      return failureOrCart.fold(
          (failure) => emit(AddToCartError(message: failure.message)),
          (cart) => emit(AddToCartLoaded()));
    });
  }
}
