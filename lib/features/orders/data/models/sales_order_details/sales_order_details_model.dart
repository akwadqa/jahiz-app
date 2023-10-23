import 'package:jahiz/features/orders/domain/entities/sales_order_details/sales_order_details.dart';

import 'items_detail_model.dart';

class SalesOrderDetailsModel extends SalesOrderDetails {
  const SalesOrderDetailsModel(
      {required super.salesOrderId,
      required super.date,
      required super.postingTime,
      required super.extraCharges,
      required super.grandTotal,
      required super.owner,
      required super.currency,
      required super.status,
      required super.additionalDiscountPercentage,
      required super.discountAmount,
      required super.paymentStatus,
      required super.itemsDetail,
      required super.orderPrice});

  factory SalesOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalesOrderDetailsModel(
      salesOrderId: json['sales_order_id'] as String,
      date: json['date'] as String,
      postingTime: json['posting_time'] as String,
      extraCharges: json['extra_charges'] as double,
      grandTotal: json['grand_total'] as double,
      owner: json['owner'] as String,
      currency: json['currency'] as String,
      status: json['status'] as String,
      additionalDiscountPercentage:
          json['additional_discount_percentage'] as double,
      discountAmount: json['discount_amount'] as double,
      paymentStatus: json['payment_status'] as String,
      itemsDetail: (json['items_detail'] as List<dynamic>)
          .map((e) => ItemsDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderPrice: json['order_price'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
        'sales_order_id': salesOrderId,
        'date': date,
        'posting_time': postingTime,
        'extra_charges': extraCharges,
        'grand_total': grandTotal,
        'owner': owner,
        'currency': currency,
        'status': status,
        'additional_discount_percentage': additionalDiscountPercentage,
        'discount_amount': discountAmount,
        'payment_status': paymentStatus,
        'items_detail':
            itemsDetail.map((e) => (e as ItemsDetailModel).toJson()).toList(),
        'order_price': orderPrice,
      };
}
