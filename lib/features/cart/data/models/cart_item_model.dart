import 'package:jahiz/features/cart/domain/entities/cart_item.dart';

import 'cart_product_option_model.dart';

class CartItemModel extends CartItem {
  const CartItemModel(
      {required super.itemCode,
      required super.itemName,
      required super.itemGroup,
      required super.image,
      required super.qty,
      required super.uom,
      required super.priceListRate,
      required super.discountPercentage,
      required super.discountAmount,
      required super.rate,
      required super.amount,
      required super.productOptions});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        itemCode: json['website_item_code'],
        itemName: json['website_item_name'],
        itemGroup: json['item_group'],
        image: json['image'],
        qty: json['qty'],
        uom: json['uom'],
        priceListRate: json['price_list_rate'],
        discountPercentage: json['discount_percentage'],
        discountAmount: json['discount_amount'],
        rate: json['rate'],
        amount: json['amount'],
        productOptions: json['product_options'] != null
            ? (json['product_options'] as List<dynamic>)
                .map((e) => CartProductOptionModel.fromJson(e))
                .toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Website_item_code'] = itemCode;
    map['qty'] = qty.toInt();
    map['product_options'] = productOptions
        .map((e) => (e as CartProductOptionModel).toJson())
        .toList();
    return map;
  }
}
