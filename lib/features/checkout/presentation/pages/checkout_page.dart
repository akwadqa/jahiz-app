import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/dashed_line.dart';
import '../../../cart/application/cart_service.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_cubit.dart';
import '../bloc/place_order/place_order_cubit.dart';
import '../widgets/place_order_button.dart';
import '../../../orders/presentaion/widgets/order_container.dart';
import '../../../orders/presentaion/widgets/order_item_widget.dart';
import '../../../orders/presentaion/widgets/your_order_text.dart';
import '../../../payment/application/payment_service.dart';
import '../../../payment/presentation/bloc/payment_methods_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import 'package:queen_validators/queen_validators.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../addresses/presentation/widgets/address_item.dart';
import '../../../cart/domain/entities/cart.dart';
import '../../../cart/presentation/bloc/update_cart/update_cart_cubit.dart';
import '../../../payment/domain/entities/payment_method.dart';
import '../../../payment/presentation/widgets/payment_method_selector.dart';
import '../../../payment/presentation/widgets/payment_widget.dart';

@RoutePage()
class CheckoutPage extends StatelessWidget implements AutoRouteWrapper {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).yourOrder),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CartLoaded) {
              final Cart cart = state.cart;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Text(S.of(context).shippingTo,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10.0),
                    AddressItem(
                        address: cart.shippingAddressDetails.first,
                        isChangeable: true),
                    const SizedBox(height: 20.0),
                    const YourOrderText(),
                    _ItemsList(cartItems: cart.items),
                    DashedLine(
                        color: Theme.of(context).primaryColor.withOpacity(0.4)),
                    const SizedBox(height: 18.0),
                    Text(S.of(context).applyDiscountCode,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.red)),
                    const SizedBox(height: 8.0),
                    _CouponSection(cart: cart),
                    const SizedBox(height: 14.0),
                    DashedLine(
                        color: Theme.of(context).primaryColor.withOpacity(0.4)),
                    const SizedBox(height: 14.0),
                    OrderContanier(
                        orderPrice: cart.totalTaxesAndCharges,
                        discountAmount: cart.discountAmount,
                        taxAmount: cart.otherChargesCalculation.isNotEmpty
                            ? cart.otherChargesCalculation.first.taxAmount
                            : null,
                        grandTotal: cart.grandTotal),
                    const SizedBox(height: 20.0),
                    Text(S.of(context).selectYourPayment,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    _PaymentAndConfirmationSection(cart: cart),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<CartCubit>()),
        BlocProvider.value(value: context.read<UpdateCartCubit>()),
        BlocProvider(
            create: (_) => getIt<PaymentMethodsCubit>()..getPaymentMethods()),
        BlocProvider(create: (_) => getIt<PlaceOrderCubit>()),
      ],
      child: this,
    );
  }
}

class _ItemsList extends StatelessWidget {
  const _ItemsList({Key? key, required this.cartItems}) : super(key: key);
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return OrderItemWidget(
            qty: cartItem.qty,
            itemName: cartItem.itemName,
            amount: cartItem.amount);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemCount: cartItems.length,
      shrinkWrap: true,
    );
  }
}

class _CouponSection extends StatefulWidget {
  const _CouponSection({Key? key, required this.cart}) : super(key: key);
  final Cart cart;

  @override
  State<_CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends State<_CouponSection> {
  final _formKey = GlobalKey<FormState>();
  final _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.cart.couponCode != null &&
        widget.cart.couponCodeDetails!.error != 1) {
      _couponController.text = widget.cart.couponCode!;
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _couponController,
            decoration: InputDecoration(
              labelText: S.of(context).enterPromoCode,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: Text(S.of(context).apply,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline)),
              ),
              border: _buildOutlineInputBorder,
              enabledBorder: _buildOutlineInputBorder,
              focusedBorder: _buildOutlineInputBorder,
            ),
            validator: qValidator([IsRequired(S.of(context).required)]),
            onSaved: (value) => context
                .read<UpdateCartCubit>()
                .applyCoupon(widget.cart, value!),
          ),
          if (widget.cart.couponCode != null &&
              widget.cart.couponCodeDetails!.error == 1) ...[
            const SizedBox(height: 4.0),
            Text(widget.cart.couponCodeDetails!.couponMessage,
                style: const TextStyle(color: AppColors.red)),
          ],
          if (widget.cart.couponCode != null &&
              widget.cart.couponCodeDetails!.error != 1) ...[
            const SizedBox(height: 8.0),
            Row(
              children: [
                Assets.images.couponIcon.svg(),
                const SizedBox(width: 5.0),
                Text(widget.cart.couponCode!,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray)),
                IconButton(
                  alignment: AlignmentDirectional.topStart,
                  padding: const EdgeInsetsDirectional.only(start: 0.0),
                  onPressed: () {
                    context
                        .read<UpdateCartCubit>()
                        .removeCoupon(widget.cart)
                        .then((value) {
                      if (value) {
                        _formKey.currentState!.reset();
                        _couponController.clear();
                      }
                    });
                  },
                  icon: const CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.red,
                      child: Icon(Icons.clear, color: Colors.white, size: 12)),
                )
              ],
            )
          ],
        ],
      ),
    );
  }

  OutlineInputBorder get _buildOutlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: AppColors.lightGray.withOpacity(0.4)),
      );
}

class _PaymentAndConfirmationSection extends StatefulWidget {
  const _PaymentAndConfirmationSection({Key? key, required this.cart})
      : super(key: key);

  final Cart cart;

  @override
  State<_PaymentAndConfirmationSection> createState() =>
      _PaymentAndConfirmationSectionState();
}

class _PaymentAndConfirmationSectionState
    extends State<_PaymentAndConfirmationSection> {
  final _formKey = GlobalKey<FormState>();
  PaymentMethod? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PaymentMethodsSelector(
            context: context,
            onSaved: (value) => _paymentMethod = value,
            onSelected: (PaymentMethod paymentMethod) {
              context
                  .read<UpdateCartCubit>()
                  .updatePaymentMethod(
                      widget.cart, paymentMethod.paymentGateway)
                  .then((_) {
                if (paymentMethod.isEmbedded == 1) {
                  _formKey.currentState!.save();
                  showPaymentBottomSheet(
                          context: context,
                          paymentMethod: _paymentMethod!,
                          total: widget.cart.grandTotal)
                      .then((value) {
                    if (value != null) {
                      if (value) {
                        context
                            .read<PlaceOrderCubit>()
                            .placeOrder(widget.cart.name, 1);
                      } else {
                        _showFailPaymentDialog();
                      }
                    } else {
                      _formKey.currentState!.reset();
                    }
                  });
                }
              });
            },
          ),
          const SizedBox(height: 20.0),
          BlocListener<PlaceOrderCubit, PlaceOrderState>(
            listener: (context, state) {
              if (state is PlaceOrderLoaded) {
                _showSuccessPaymentDialog(
                    state.orderId,
                    _paymentMethod!.isOffline == 1
                        ? S.of(context).orderPlaced
                        : null);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: PlaceOrderButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_paymentMethod!.isOffline == 1) {
                      context
                          .read<PlaceOrderCubit>()
                          .placeOrder(widget.cart.name);
                    } else {
                      final paymentService = PaymentService(
                          paymentMethod: _paymentMethod!,
                          total: widget.cart.grandTotal);
                      context.read<PlaceOrderCubit>().setLoadingState();
                      paymentService.initiatePayment(onFail: () {
                        _showFailPaymentDialog();
                      }, onSuccess: () {
                        context
                            .read<PlaceOrderCubit>()
                            .placeOrder(widget.cart.name, 1);
                      }).then((value) =>
                          context.read<PlaceOrderCubit>().setInitailState());
                    }
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<dynamic> _showSuccessPaymentDialog(String salesOrderId,
      [String? message]) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: S.of(context).thankYou,
      desc: message ?? S.of(context).orderAndPaymentPlaced,
      btnOkOnPress: () {
        getIt<CartService>().clearCart();
        context.router
            .pushAndPopUntil(const MainRoute(), predicate: (route) => false);
        context.pushRoute(OrderDetailsRoute(salesOrderId: salesOrderId));
      },
      btnOkText: S.of(context).orderDetails,
      btnCancelText: S.of(context).homePage,
      btnCancelColor: Theme.of(context).primaryColor,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      btnCancelOnPress: () {
        getIt<CartService>().clearCart();
        context.router
            .pushAndPopUntil(const MainRoute(), predicate: (route) => false);
      },
    ).show();
  }

  Future<dynamic> _showFailPaymentDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: S.of(context).paymentIsFailed,
      desc: S.of(context).orderPaymentFailed,
      btnOkOnPress: () {},
      btnOkText: S.of(context).ok,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      btnOkColor: Theme.of(context).primaryColor,
    ).show();
  }
}
