import '../../../domain/entities/sales_order_details/items_detail.dart';

class ItemsDetailModel extends ItemsDetail {
  const ItemsDetailModel({
    required super.websiteItemCode,
    required super.websiteItemName,
    required super.qty,
    required super.netRate,
    required super.netAmount,
    required super.itemGroup,
    required super.image,
    required super.productOption,
    required super.itemImage,
    required super.backgroundColor,
    required super.productOptions,
  });

  factory ItemsDetailModel.fromJson(Map<String, dynamic> json) =>
      ItemsDetailModel(
        websiteItemCode: json['website_item_code'] as String,
        websiteItemName: json['website_item_name'] as String,
        qty: json['qty'] as double,
        netRate: json['net_rate'] as double,
        netAmount: json['net_amount'] as double,
        itemGroup: json['item_group'] as String,
        image: json['image'] as String,
        productOption: json['product_option'] as dynamic,
        itemImage: json['item_image'] as String,
        backgroundColor: json['background_color'] as String?,
        productOptions: json['product_options'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'website_item_code': websiteItemCode,
        'website_item_name': websiteItemName,
        'qty': qty,
        'net_rate': netRate,
        'net_amount': netAmount,
        'item_group': itemGroup,
        'image': image,
        'product_option': productOption,
        'item_image': itemImage,
        'background_color': backgroundColor,
        'product_options': productOptions,
      };
}
