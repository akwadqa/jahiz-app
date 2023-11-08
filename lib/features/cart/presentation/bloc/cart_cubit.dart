import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/widgets/sign_up_login_bottom_sheet.dart';
import '../../../auth/application/auth_cubit.dart';
import '../../application/cart_service.dart';
import '../../domain/usecases/get_cart.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../addresses/presentation/widgets/location_selector_widget.dart';
import '../../domain/entities/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._getCartUseCase, this._authCubit) : super(CartInitial());

  final AuthCubit _authCubit;

  final GetCartUseCase _getCartUseCase;

  void getCart() async {
    emit(CartLoading());
    final failureOrCart = await _getCartUseCase();
    failureOrCart.fold(
        (failure) => emit(CartError(message: failure.message)),
        (cart) =>
            cart == null ? emit(CartEmpty()) : emit(CartLoaded(cart: cart)));
  }

  void setCart(Cart cart) {
    emit(CartLoaded(cart: cart));
  }

  void setEmptyCart() {
    emit(CartEmpty());
  }

  void checkout(Cart cart, BuildContext context) async {
    if (_authCubit.state is Authenticated) {
      if (cart.shippingAddressDetails.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).addShippingAddress)));
        showLocationSelectorBottomSheet(context).then((address) {
          if (address != null) {
            getIt<CartService>().updateCartAddress(address);
          }
        });
      } else {
        await context.pushRoute(const CheckoutRoute());
      }
    } else {
      await showSignUpLoginBottomSheet(context);
    }
  }
}
