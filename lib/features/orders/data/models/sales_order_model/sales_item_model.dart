import '../../../domain/entities/sales_order/sales_item.dart';

class SalesItemModel extends SalesItem {
  const SalesItemModel(
      {required super.websiteItemCode,
      required super.websiteItemName,
      required super.qty,
      required super.netRate,
      required super.netAmount,
      required super.itemGroup,
      required super.image,
      required super.websiteImage});

  factory SalesItemModel.fromJson(Map<String, dynamic> json) => SalesItemModel(
        websiteItemCode: json['website_item_code'] as String,
        websiteItemName: json['website_item_name'] as String,
        qty: json['qty'] as num,
        netRate: json['net_rate'] as double,
        netAmount: json['net_amount'] as double,
        itemGroup: json['item_group'] as String,
        image: json['image'] as String,
        websiteImage: json['website_image'] as String
      );

  Map<String, dynamic> toJson() => {
        'website_item_code': websiteItemCode,
        'website_item_name': websiteItemName,
        'qty': qty,
        'net_rate': netRate,
        'net_amount': netAmount,
        'item_group': itemGroup,
        'image': image,
        'website_image': websiteImage
      };
}
