import 'coupon_code_details_model.dart';
import '../../domain/entities/cart.dart';

import '../../../addresses/data/models/address_model.dart';
import 'cart_item_model.dart';
import 'other_charges_calculation_model.dart';

class CartModel extends Cart {
  const CartModel(
      {required super.name,
      required super.transactionDate,
      required super.shippingAddressName,
      required super.currency,
      required super.totalQty,
      required super.totalTaxesAndCharges,
      required super.additionalDiscountPercentage,
      required super.discountAmount,
      required super.grandTotal,
      required super.status,
      required super.couponCode,
      required super.couponCodeDetails,
      required super.shippingAddressDetails,
      required super.items,
      required super.otherChargesCalculation,
      required super.paymentGateway});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        name: json['name'],
        transactionDate: json['transaction_date'],
        shippingAddressName: json['shipping_address_name'],
        currency: json['currency'],
        totalQty: json['total_qty'],
        totalTaxesAndCharges: json['total_taxes_and_charges'],
        additionalDiscountPercentage: json['additional_discount_percentage'],
        discountAmount: json['discount_amount'],
        grandTotal: json['grand_total'],
        status: json['status'],
        couponCode: json['coupon_code'],
        couponCodeDetails: json['coupon_code_details'] != null &&
                json['coupon_code_details'].isNotEmpty
            ? CouponCodeDetailsModel.fromJson(json['coupon_code_details'])
            : null,
        shippingAddressDetails: json['shipping_address_details'] != null
            ? (json['shipping_address_details'] as List<dynamic>)
                .map((e) => AddressModel.fromJson(e))
                .toList()
            : [],
        items: json['items'] != null
            ? (json['items'] as List<dynamic>)
                .map((e) => CartItemModel.fromJson(e))
                .toList()
            : [],
        otherChargesCalculation: json['other_charges_calculation'] != null
            ? (json['other_charges_calculation'] as List<dynamic>)
                .map((e) => OtherChargesCalculationModel.fromJson(e))
                .toList()
            : [],
        paymentGateway: json['payment_gateway']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupon_code'] = couponCode ?? "";
    map["shipping_address_name"] = shippingAddressName;
    if (shippingAddressDetails?.isNotEmpty ?? false) {
      map['shipping_address_name'] = shippingAddressDetails?.first.addressId;
    }
    map['items'] = items?.map((e) => (e as CartItemModel).toJson()).toList();
    map['payment_gateway'] = paymentGateway ?? "";
    return map;
  }
}
