import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../addresses/domain/entities/address.dart';
import '../domain/entities/cart.dart';
import '../domain/entities/cart_item.dart';
import '../domain/entities/cart_product_option.dart';
import '../presentation/bloc/cart_cubit.dart';
import '../presentation/bloc/update_cart/update_cart_cubit.dart';
import '../../products/domain/entities/product.dart';

class CartService {
  const CartService(this._cartCubit, this._updateCartCubit);

  final CartCubit _cartCubit;

  final UpdateCartCubit _updateCartCubit;

  void updateCartAddress(Address address) {
    _updateCartCubit.updateAddress(
        (_cartCubit.state as CartLoaded).cart, address);
  }

  Future<Either<Failure, Cart?>> addToCart<T extends dynamic>(
      {required T product,
      required int quantity,
      List<CartProductOption>? cartProductOptions}) {
    final cartState = _cartCubit.state;
    Cart? cart;
    if (cartState is CartLoaded) {
      cart = (_cartCubit.state as CartLoaded).cart;
      final productId =
          product is Product ? product.productId : product.websiteItemId;
      if (cart.items.any((element) => element.itemCode == productId)) {
        final excistingProduct =
            cart.items.firstWhere((element) => element.itemCode == productId);
        final CartItem cartItem = excistingProduct.copyWith(
            qty: excistingProduct.qty + quantity.toDouble(),
            productOptions: cartProductOptions);
        cart.items.removeWhere((element) => element.itemCode == productId);
        cart.items.add(cartItem.toModel());
      } else {
        cart.items.add(product
            .toCartItem()
            .copyWith(
                productOptions: cartProductOptions, qty: quantity.toDouble())
            .toModel());
      }
    } else {
      cart = Cart(
          items: [
            product
                .toCartItem()
                .copyWith(
                    productOptions: cartProductOptions,
                    qty: quantity.toDouble())
                .toModel()
          ],
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
    return _updateCartCubit.callUpdateCart(cart);
  }

  void clearCart() {
    _cartCubit.setEmptyCart();
  }
}
