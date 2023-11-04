import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/widgets/sign_up_login_bottom_sheet.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/features/cart/application/cart_service.dart';
import 'package:jahiz/features/cart/domain/usecases/get_cart.dart';
import 'package:jahiz/features/orders/presentaion/bloc/place_order/place_order_cubit.dart';
import 'package:jahiz/features/payment/presentation/bloc/payment_methods_cubit.dart';
import 'package:jahiz/features/cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import 'package:jahiz/features/payment/presentation/pages/checkout_page.dart';
import 'package:jahiz/generated/l10n.dart';
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
            CartService.updateCartAddress(address);
          }
        });
      } else {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: context.read<CartCubit>()),
                        BlocProvider.value(
                            value: context.read<UpdateCartCubit>()),
                        BlocProvider(
                            create: (_) => getIt<PaymentMethodsCubit>()
                              ..getPaymentMethods()),
                        BlocProvider(create: (_) => getIt<PlaceOrderCubit>()),
                      ],
                      child: const CheckoutPage(),
                    )));
      }
    } else {
      await showSignUpLoginBottomSheet(context);
    }
  }
}
