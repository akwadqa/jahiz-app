import '../../domain/entities/cart_product_option.dart';

class CartProductOptionModel extends CartProductOption {
  const CartProductOptionModel(
      {required super.productOptionFieldName,
      required super.productOptionFieldValue,
      required super.isPriceModifier});

  factory CartProductOptionModel.fromJson(Map<String, dynamic> json) {
    return CartProductOptionModel(
        productOptionFieldName: json['product_option_field_name'],
        productOptionFieldValue: json['product_option_field_value'],
        isPriceModifier: json['is_price_modifier']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['option_name'] = productOptionFieldName;
    map['option_value'] = productOptionFieldValue;
    map['is_price_modifier'] = isPriceModifier;
    return map;
  }
}
