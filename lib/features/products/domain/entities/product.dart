import 'package:equatable/equatable.dart';
import 'package:jahiz/features/products/domain/entities/home_block_data.dart';

import '../../../cart/domain/entities/cart_item.dart';

class Product extends Equatable implements HomeBlockData {
  final String productImage;
  final String productTitle;
  final double productPrice;
  final String discountPercent;
  final double discountAmount;
  final double discountedPrice;
  final String productId;
  final String? backgroundColor;
  final int hasOptions;

  const Product(
      {required this.productImage,
      required this.productTitle,
      required this.productPrice,
      required this.discountPercent,
      required this.discountAmount,
      required this.discountedPrice,
      required this.productId,
      required this.backgroundColor,
      required this.hasOptions});

  Product copyWith(
          {String? productImage,
          String? productTitle,
          double? productPrice,
          String? discountPercent,
          double? discountAmount,
          double? discountedPrice,
          String? productId,
          String? backgroundColor,
          int? hasOptions}) =>
      Product(
          productImage: productImage ?? this.productImage,
          productTitle: productTitle ?? this.productTitle,
          productPrice: productPrice ?? this.productPrice,
          discountPercent: discountPercent ?? this.discountPercent,
          discountAmount: discountAmount ?? this.discountAmount,
          discountedPrice: discountedPrice ?? this.discountedPrice,
          productId: productId ?? this.productId,
          backgroundColor: backgroundColor ?? this.backgroundColor,
          hasOptions: hasOptions ?? this.hasOptions);

  CartItem toCartItem() => CartItem(
      itemCode: productId,
      itemName: productTitle,
      itemGroup: '',
      image: '',
      qty: 0.0,
      uom: '',
      priceListRate: discountedPrice,
      discountPercentage: 0.0,
      discountAmount: discountAmount,
      rate: 0.0,
      amount: 0.0,
      productOptions: const []);

  @override
  List<Object?> get props => [
        productImage,
        productTitle,
        productPrice,
        discountPercent,
        discountAmount,
        discountedPrice,
        productId,
        backgroundColor,
        hasOptions
      ];
}
