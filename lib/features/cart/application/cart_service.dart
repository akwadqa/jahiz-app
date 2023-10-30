import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';
import 'package:jahiz/features/cart/domain/entities/cart.dart';
import 'package:jahiz/features/cart/domain/entities/cart_item.dart';
import 'package:jahiz/features/cart/domain/entities/cart_product_option.dart';
import 'package:jahiz/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:jahiz/features/cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/injection_container.dart';

class CartService {
  static void updateCartAddress(Address address) {
    getIt<UpdateCartCubit>()
        .updateAddress((getIt<CartCubit>().state as CartLoaded).cart, address);
  }

  static Future<Either<Failure, Cart?>> addToCart<T extends dynamic>(
      {required T product,
      required int quantity,
      List<CartProductOption>? cartProductOptions}) {
    final cartState = getIt<CartCubit>().state;
    Cart? cart;
    if (cartState is CartLoaded) {
      cart = (getIt<CartCubit>().state as CartLoaded).cart;
      final productId = product is Product ? product.productId : product.websiteItemId;
      if (cart.items
          .any((element) => element.itemCode == productId)) {
        final excistingProduct = cart.items
            .firstWhere((element) => element.itemCode == productId);
        final CartItem cartItem = excistingProduct.copyWith(
            qty: excistingProduct.qty + quantity.toDouble(),
            productOptions: cartProductOptions);
        cart.items.removeWhere(
            (element) => element.itemCode == productId);
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
    return getIt<UpdateCartCubit>().callUpdateCart(cart);
  }
}