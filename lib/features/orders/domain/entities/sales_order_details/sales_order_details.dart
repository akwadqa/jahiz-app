import 'package:equatable/equatable.dart';

import 'items_detail.dart';

class SalesOrderDetails extends Equatable {
  final String salesOrderId;
  final String date;
  final String postingTime;
  final double extraCharges;
  final double grandTotal;
  final String owner;
  final String currency;
  final String status;
  final double additionalDiscountPercentage;
  final double discountAmount;
  final String paymentStatus;
  final List<ItemsDetail> itemsDetail;
  final double orderPrice;

  const SalesOrderDetails({
    required this.salesOrderId,
    required this.date,
    required this.postingTime,
    required this.extraCharges,
    required this.grandTotal,
    required this.owner,
    required this.currency,
    required this.status,
    required this.additionalDiscountPercentage,
    required this.discountAmount,
    required this.paymentStatus,
    required this.itemsDetail,
    required this.orderPrice,
  });

  @override
  List<Object?> get props {
    return [
      salesOrderId,
      date,
      postingTime,
      extraCharges,
      grandTotal,
      owner,
      currency,
      status,
      additionalDiscountPercentage,
      discountAmount,
      paymentStatus,
      itemsDetail,
      orderPrice,
    ];
  }
}
