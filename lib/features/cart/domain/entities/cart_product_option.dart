import 'package:equatable/equatable.dart';
import 'package:jahiz/features/cart/data/models/cart_product_option_model.dart';

class CartProductOption extends Equatable {
  final String productOptionFieldName;
  final String productOptionFieldValue;
  final int isPriceModifier;

  const CartProductOption(
      {required this.productOptionFieldName,
      required this.productOptionFieldValue,
      required this.isPriceModifier});

  CartProductOption copyWith(
      {String? productOptionFieldName,
      String? productOptionFieldValue,
      int? isPriceModifier}) {
    return CartProductOption(
        productOptionFieldName:
            productOptionFieldName ?? this.productOptionFieldName,
        productOptionFieldValue:
            productOptionFieldValue ?? this.productOptionFieldValue,
        isPriceModifier: isPriceModifier ?? this.isPriceModifier);
  }

  CartProductOptionModel toModel() {
    return CartProductOptionModel(
        productOptionFieldName: productOptionFieldName,
        productOptionFieldValue: productOptionFieldValue,
        isPriceModifier: isPriceModifier);
  }

  @override
  List<Object?> get props =>
      [productOptionFieldName, productOptionFieldValue, isPriceModifier];
}
