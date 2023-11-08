import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

import 'cart_product_option.dart';

class CartItem extends Equatable {
  final String itemCode;
  final String itemName;
  final String itemGroup;
  final String image;
  final double qty;
  final String uom;
  final double priceListRate;
  final double discountPercentage;
  final double discountAmount;
  final double rate;
  final double amount;
  final List<CartProductOption> productOptions;

  const CartItem(
      {required this.itemCode,
      required this.itemName,
      required this.itemGroup,
      required this.image,
      required this.qty,
      required this.uom,
      required this.priceListRate,
      required this.discountPercentage,
      required this.discountAmount,
      required this.rate,
      required this.amount,
      required this.productOptions});

  CartItem copyWith({
    String? itemCode,
    String? itemName,
    String? itemGroup,
    String? image,
    double? qty,
    String? uom,
    double? priceListRate,
    double? discountPercentage,
    double? discountAmount,
    double? rate,
    double? amount,
    List<CartProductOption>? productOptions,
  }) {
    return CartItem(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      itemGroup: itemGroup ?? this.itemGroup,
      image: image ?? this.image,
      qty: qty ?? this.qty,
      uom: uom ?? this.uom,
      priceListRate: priceListRate ?? this.priceListRate,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      productOptions: productOptions ?? this.productOptions,
    );
  }

  CartItemModel toModel() {
    return CartItemModel(
      itemCode: itemCode,
      itemName: itemName,
      itemGroup: itemGroup,
      image: image,
      qty: qty,
      uom: uom,
      priceListRate: priceListRate,
      discountPercentage: discountPercentage,
      discountAmount: discountAmount,
      rate: rate,
      amount: amount,
      productOptions: productOptions.map((e) => e.toModel()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        itemCode,
        itemName,
        itemGroup,
        image,
        qty,
        uom,
        priceListRate,
        discountPercentage,
        discountAmount,
        rate,
        amount,
        productOptions
      ];
}
