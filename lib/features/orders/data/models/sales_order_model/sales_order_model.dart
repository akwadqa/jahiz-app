import 'sales_item_model.dart';
import '../../../domain/entities/sales_order/sales_order.dart';

class SalesOrderModel extends SalesOrder {
  const SalesOrderModel(
      {required super.salesOrderId,
      required super.date,
      required super.status,
      required super.orderStatus,
      required super.postingTime,
      required super.grandTotal,
      required super.currency,
      required super.owner,
      required super.totalTaxesAndCharges,
      required super.items});

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) =>
      SalesOrderModel(
        salesOrderId: json['sales_order_id'] as String,
        date: json['date'] as String,
        status: json['status'] as int,
        orderStatus: json['order_status'] as String,
        postingTime: json['posting_time'] as String,
        grandTotal: json['grand_total'] as double,
        currency: json['currency'] as String,
        owner: json['owner'] as String,
        totalTaxesAndCharges: json['total_taxes_and_charges'] as double,
        items: (json['items'] as List<dynamic>)
            .map((e) => SalesItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'sales_order_id': salesOrderId,
        'date': date,
        'status': status,
        'order_status': orderStatus,
        'posting_time': postingTime,
        'grand_total': grandTotal,
        'currency': currency,
        'owner': owner,
        'total_taxes_and_charges': totalTaxesAndCharges,
        'items': items.map((e) => (e as SalesItemModel).toJson()).toList(),
      };
}
