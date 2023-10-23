import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/usecases/update_cart.dart';

part 'update_cart_state.dart';

enum UpdateQuantityType { increase, decrease }

class UpdateCartCubit extends Cubit<UpdateCartState> {
  UpdateCartCubit(this._updateCartUseCase) : super(UpdateCartInitial());

  final UpdateCartUseCase _updateCartUseCase;

  Future<bool> _updateCart(Cart cart) async {
    emit(UpdateCartLoading());
    final failureOrCart = await _updateCartUseCase(cart);
    return failureOrCart.fold((failure) {
      emit(UpdateCartError(message: failure.message));
      return false;
    }, (cart) {
      cart == null
          ? emit(UpdateCartEmpty())
          : emit(UpdateCartLoaded(cart: cart));
      return true;
    });
  }

  Future<void> increaseQuantity(Cart cart, int index) async =>
      _updateQuantity(cart, index, UpdateQuantityType.increase);

  Future<void> decreaseQuantity(Cart cart, int index) async =>
      _updateQuantity(cart, index, UpdateQuantityType.decrease);

  Future<void> _updateQuantity(
      Cart cart, int index, UpdateQuantityType updateQuantityType) async {
    final clonedCart = await cart.clone();
    if (updateQuantityType == UpdateQuantityType.increase) {
      final cartItem = clonedCart.items[index]
          .copyWith(qty: clonedCart.items[index].qty + 1);
      final updatedCart = clonedCart.copyWith(
          items: clonedCart.items..[index] = cartItem.toModel());
      _updateCart(updatedCart);
    } else {
      if (clonedCart.items[index].qty > 1) {
        final cartItem = clonedCart.items[index]
            .copyWith(qty: clonedCart.items[index].qty - 1);
        final updatedCart = clonedCart.copyWith(
            items: clonedCart.items..[index] = cartItem.toModel());
        _updateCart(updatedCart);
      }
    }
  }

  Future<bool> removeItem(Cart cart, int index) async {
    final clonedCart = await cart.clone();
    clonedCart.items.removeAt(index);
    return _updateCart(clonedCart);
  }

  Future<void> updateAddress(Cart cart, Address address) async {
    final clonedCart = await cart.clone();
    final updatedCart = clonedCart.copyWith(shippingAddressDetails: [address]);
    _updateCart(updatedCart);
  }

  Future<void> applyCoupon(Cart cart, String couponCode) async {
    final clonedCart = await cart.clone();
    final updatedCart = clonedCart.copyWith(couponCode: couponCode);
    _updateCart(updatedCart);
  }

  Future<bool> removeCoupon(Cart cart) async {
    final clonedCart = await cart.clone();
    final updatedCart = clonedCart.copyWith(couponCode: '');
    return _updateCart(updatedCart);
  }
}
