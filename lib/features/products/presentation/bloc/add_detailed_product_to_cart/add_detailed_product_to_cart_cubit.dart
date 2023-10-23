import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jahiz/features/cart/domain/entities/cart_item.dart';
import 'package:jahiz/features/cart/domain/entities/cart_product_option.dart';
import 'package:jahiz/features/cart/domain/usecases/get_cart.dart';
import 'package:jahiz/features/cart/domain/usecases/update_cart.dart';
import 'package:jahiz/features/products/domain/entities/product_option.dart';
import 'package:jahiz/generated/l10n.dart';

import '../../../../../core/shared_functions.dart';

import '../../../../cart/domain/entities/cart.dart';
import '../../../domain/entities/detailed_product.dart';

part 'add_detailed_product_to_cart_state.dart';

class AddDetailedProductToCartCubit
    extends Cubit<AddDetailedProductToCartState> {
  AddDetailedProductToCartCubit(this._updateCartUseCase, this._getCartUseCase)
      : super(AddDetailedProductToCartInitial());

  final GetCartUseCase _getCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  final List<CartProductOption> _cartProductOptions = [];

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.requiredValidator(context);

  String? selectorValidator(String? value, BuildContext context) =>
      value == null || value.isEmpty ? S.of(context).required : null;

  void onSaved(ProductOption productOption, String value) {
    _cartProductOptions.add(CartProductOption(
        productOptionFieldName: productOption.optionName,
        productOptionFieldValue: value,
        isPriceModifier: productOption.isPriceModifier));
  }

  Future<void> addToCart(DetailedProduct detailedProduct, int quantity) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _submit(detailedProduct, quantity);
    }
  }

  Future<void> _submit(DetailedProduct detailedProduct, int quantity) async {
    emit(AddDetailedProductToCartLoading());
    final failureOrCart = await _getCartUseCase();
    return failureOrCart.fold(
        (failure) =>
            emit(AddDetailedProductToCartError(message: failure.message)),
        (cart) async {
      if (cart != null) {
        if (cart.items.any(
            (element) => element.itemCode == detailedProduct.websiteItemId)) {
          final product = cart.items.firstWhere(
              (element) => element.itemCode == detailedProduct.websiteItemId);
          final CartItem cartItem = product.copyWith(
              qty: product.qty + quantity.toDouble(),
              productOptions: _cartProductOptions);
          cart.items.removeWhere(
              (element) => element.itemCode == detailedProduct.websiteItemId);
          cart.items.add(cartItem.toModel());
        } else {
          cart.items.add(detailedProduct
              .toCartItem()
              .copyWith(
                  productOptions: _cartProductOptions, qty: quantity.toDouble())
              .toModel());
        }
      } else {
        cart = Cart(
            items: [
              detailedProduct
                  .toCartItem()
                  .copyWith(
                      productOptions: _cartProductOptions,
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
      final failureOrCart = await _updateCartUseCase(cart);
      return failureOrCart.fold(
          (failure) =>
              emit(AddDetailedProductToCartError(message: failure.message)),
          (cart) => emit(AddDetailedProductToCartLoaded()));
    });
  }
}
