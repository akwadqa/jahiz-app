import '../../../../core/shared_functions.dart';
import '../../domain/entities/product.dart';

import '../../../home/data/models/home_block_data_model.dart';

class ProductModel extends Product implements HomeBlockDataModel {
  const ProductModel(
      {required super.productImage,
      required super.productTitle,
      required super.productPrice,
      required super.discountPercent,
      required super.discountAmount,
      required super.discountedPrice,
      required super.productId,
      required super.backgroundColor,
      required super.hasOptions});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productImage: SharedFunctions.getImageUrl(json['product_image']),
        productTitle: json['product_title'],
        productPrice: json['product_price'],
        discountPercent: json['discount_percent'],
        discountAmount: json['discount_amount'],
        discountedPrice: json['discounted_price'],
        productId: json['product_id'],
        backgroundColor: json['background_color'],
        hasOptions: json['has_options']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_image'] = productImage;
    map['product_title'] = productTitle;
    map['product_price'] = productPrice;
    map['discount_percent'] = discountPercent;
    map['discount_amount'] = discountAmount;
    map['discounted_price'] = discountedPrice;
    map['product_id'] = productId;
    map['background_color'] = backgroundColor;
    map['has_options'] = hasOptions;
    return map;
  }
}
