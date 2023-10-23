import 'package:equatable/equatable.dart';

import 'sales_item.dart';

class SalesOrder extends Equatable {
  final String salesOrderId;
  final String date;
  final int status;
  final String orderStatus;
  final String postingTime;
  final double grandTotal;
  final String currency;
  final String owner;
  final double totalTaxesAndCharges;
  final List<SalesItem> items;

  const SalesOrder({
    required this.salesOrderId,
    required this.date,
    required this.status,
    required this.orderStatus,
    required this.postingTime,
    required this.grandTotal,
    required this.currency,
    required this.owner,
    required this.totalTaxesAndCharges,
    required this.items,
  });

  @override
  List<Object> get props {
    return [
      salesOrderId,
      date,
      status,
      orderStatus,
      postingTime,
      grandTotal,
      currency,
      owner,
      totalTaxesAndCharges,
      items,
    ];
  }
}
