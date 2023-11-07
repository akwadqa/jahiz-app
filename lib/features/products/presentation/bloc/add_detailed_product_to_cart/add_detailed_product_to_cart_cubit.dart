import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jahiz/features/cart/application/cart_service.dart';
import 'package:jahiz/features/cart/domain/entities/cart_product_option.dart';
import 'package:jahiz/features/products/domain/entities/product_option.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';

import '../../../../../core/shared_functions.dart';

import '../../../domain/entities/detailed_product.dart';

part 'add_detailed_product_to_cart_state.dart';

class AddDetailedProductToCartCubit
    extends Cubit<AddDetailedProductToCartState> {
  AddDetailedProductToCartCubit() : super(AddDetailedProductToCartInitial());

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
    final failureOrCart = await getIt<CartService>().addToCart(
        product: detailedProduct,
        quantity: quantity,
        cartProductOptions: _cartProductOptions);
    return failureOrCart.fold(
        (failure) =>
            emit(AddDetailedProductToCartError(message: failure.message)),
        (cart) => emit(AddDetailedProductToCartLoaded()));
  }
}
