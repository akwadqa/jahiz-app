import 'package:equatable/equatable.dart';
import 'package:jahiz/features/addresses/domain/entities/address.dart';
import 'package:jahiz/features/cart/data/models/Cart_model.dart';

import 'cart_item.dart';
import 'coupon_code_details.dart';
import 'other_charges_calculation.dart';

class Cart extends Equatable {
  final String name;
  final String transactionDate;
  final String shippingAddressName;
  final String currency;
  final double totalQty;
  final double totalTaxesAndCharges;
  final double additionalDiscountPercentage;
  final double discountAmount;
  final double grandTotal;
  final String status;
  final String? couponCode;
  final CouponCodeDetails? couponCodeDetails;
  final List<Address> shippingAddressDetails;
  final List<CartItem> items;
  final List<OtherChargesCalculation> otherChargesCalculation;

  const Cart(
      {required this.name,
      required this.transactionDate,
      required this.shippingAddressName,
      required this.currency,
      required this.totalQty,
      required this.totalTaxesAndCharges,
      required this.additionalDiscountPercentage,
      required this.discountAmount,
      required this.grandTotal,
      required this.status,
      required this.couponCode,
      required this.couponCodeDetails,
      required this.shippingAddressDetails,
      required this.items,
      required this.otherChargesCalculation});

  Cart copyWith(
      {String? name,
      String? transactionDate,
      String? shippingAddressName,
      String? currency,
      double? totalQty,
      double? totalTaxesAndCharges,
      double? additionalDiscountPercentage,
      double? discountAmount,
      double? grandTotal,
      String? status,
      String? couponCode,
      CouponCodeDetails? couponCodeDetails,
      List<Address>? shippingAddressDetails,
      List<CartItem>? items,
      List<OtherChargesCalculation>? otherChargesCalculation}) {
    return Cart(
        name: name ?? this.name,
        transactionDate: transactionDate ?? this.transactionDate,
        shippingAddressName: shippingAddressName ?? this.shippingAddressName,
        currency: currency ?? this.currency,
        totalQty: totalQty ?? this.totalQty,
        totalTaxesAndCharges: totalTaxesAndCharges ?? this.totalTaxesAndCharges,
        additionalDiscountPercentage:
            additionalDiscountPercentage ?? this.additionalDiscountPercentage,
        discountAmount: discountAmount ?? this.discountAmount,
        grandTotal: grandTotal ?? this.grandTotal,
        status: status ?? this.status,
        couponCode: couponCode ?? this.couponCode,
        couponCodeDetails: couponCodeDetails ?? this.couponCodeDetails,
        shippingAddressDetails:
            shippingAddressDetails ?? this.shippingAddressDetails,
        items: items ?? this.items,
        otherChargesCalculation:
            otherChargesCalculation ?? this.otherChargesCalculation);
  }

  CartModel toModel() {
    return CartModel(
        name: name,
        transactionDate: transactionDate,
        shippingAddressName: shippingAddressName,
        currency: currency,
        totalQty: totalQty,
        totalTaxesAndCharges: totalTaxesAndCharges,
        additionalDiscountPercentage: additionalDiscountPercentage,
        discountAmount: discountAmount,
        grandTotal: grandTotal,
        status: status,
        couponCode: couponCode,
        couponCodeDetails: couponCodeDetails,
        shippingAddressDetails:
            shippingAddressDetails.map((e) => e.toModel()).toList(),
        items: items.map((e) => e.toModel()).toList(),
        otherChargesCalculation:
            otherChargesCalculation.map((e) => e.toModel()).toList());
  }

  @override
  List<Object?> get props => [
        name,
        transactionDate,
        shippingAddressName,
        currency,
        totalQty,
        totalTaxesAndCharges,
        additionalDiscountPercentage,
        discountAmount,
        grandTotal,
        status,
        couponCode,
        couponCodeDetails,
        shippingAddressDetails,
        items,
        otherChargesCalculation
      ];
}
