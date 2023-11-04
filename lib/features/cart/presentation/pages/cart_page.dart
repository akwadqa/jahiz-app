import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jahiz/core/widgets/app_cached_network_image.dart';
import 'package:jahiz/core/widgets/dashed_line.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/features/cart/domain/entities/cart_item.dart';
import 'package:jahiz/features/cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/change_quantity_button.dart';
import '../../../../core/widgets/no_elements_widget.dart';
import '../../../../core/widgets/sign_up_login_bottom_sheet.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart_cubit.dart';

@RoutePage()
class CartPage extends StatelessWidget implements AutoRouteWrapper {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is Unauthenticated) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                onPressed: () => showSignUpLoginBottomSheet(context),
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                child: Text(S.of(context).login)),
          ),
        );
      }
      return this;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppHeader(title: S.of(context).myCart),
        Positioned.fill(
            top: 130,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35.0))),
              padding: EdgeInsets.zero,
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0))),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 20.0),
                                    itemCount: state.cart.items.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return _CartItem(
                                          cart: state.cart, index: index);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(height: 8.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DashedLine(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(S.of(context).subTotal,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Text(
                                          '${S.of(context).qar} ${state.cart.totalTaxesAndCharges.toStringAsFixed(2)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ElevatedButton(
                              onPressed: () => context
                                  .read<CartCubit>()
                                  .checkout(state.cart, context),
                              child: Text(S.of(context).checkout)),
                        ),
                        const SizedBox(height: 100.0),
                      ],
                    );
                  }
                  if (state is CartError) {
                    return AppErrorWidget(
                        errorText: state.message,
                        onRetryClicked: context.read<CartCubit>().getCart);
                  }
                  if (state is CartEmpty) {
                    return const NoElementsWidget();
                  }
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                },
              ),
            ))
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key, required this.cart, required this.index})
      : super(key: key);
  final Cart cart;
  final int index;
  @override
  Widget build(BuildContext context) {
    final CartItem cartItem = cart.items[index];
    return Dismissible(
      key: Key(cartItem.itemCode),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: 20.0),
        child: Assets.images.deleteIcon.svg(),
      ),
      confirmDismiss: (_) async {
        return await context.read<UpdateCartCubit>().removeItem(cart, index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(17.0)),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 6.0,
                        offset: const Offset(0.0, 0.0),
                      )
                    ]),
                clipBehavior: Clip.antiAlias,
                height: 100,
                width: 100,
                child: AppCachedNetworkImage(imageUrl: cartItem.image)),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    cartItem.itemName,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    cartItem.productOptions
                        .map((e) => e.productOptionFieldValue)
                        .join(', '),
                    style: const TextStyle(
                        fontSize: 14.0, color: AppColors.darkGray),
                  ),
                  const SizedBox(height: 5.0),
                  BlocListener<UpdateCartCubit, UpdateCartState>(
                    listenWhen: (previous, current) => previous != current,
                    listener: (context, state) {
                      if (state is UpdateCartLoaded) {
                        Navigator.pop(context);
                        context.read<CartCubit>().setCart(state.cart);
                      }
                      if (state is UpdateCartEmpty) {
                        Navigator.pop(context);
                        context.read<CartCubit>().setEmptyCart();
                      }
                      if (state is UpdateCartError) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: state.message,
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      }
                      if (state is UpdateCartLoading) {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => const Center(
                                child: CircularProgressIndicator.adaptive()),
                            opaque: false,
                            barrierColor: Colors.black.withOpacity(0.1),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChangeQuantityButton(
                                onPressed: () => context
                                    .read<UpdateCartCubit>()
                                    .decreaseQuantity(cart, index),
                                icon: Icons.remove,
                                padding: const EdgeInsets.all(8.0)),
                            const SizedBox(width: 10),
                            Text(cartItem.qty.toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor)),
                            const SizedBox(width: 10),
                            ChangeQuantityButton(
                                onPressed: () => context
                                    .read<UpdateCartCubit>()
                                    .increaseQuantity(cart, index),
                                icon: Icons.add,
                                padding: const EdgeInsets.all(8.0)),
                          ],
                        ),
                        Text(
                            '${cartItem.amount.toStringAsFixed(2)} ${S.of(context).qar}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
