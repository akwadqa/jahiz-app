import '../../../home/data/models/additional_image_model.dart';
import 'product_option_model.dart';
import 'product_specification_model.dart';
import '../../domain/entities/detailed_product.dart';

import '../../../../core/shared_functions.dart';

class DetailedProductModel extends DetailedProduct {
  const DetailedProductModel(
      {required super.websiteItemId,
      required super.itemCode,
      required super.websiteItemName,
      required super.itemGroup,
      required super.stockUom,
      required super.itemDescription,
      required super.backgroundColor,
      required super.published,
      required super.websiteImage,
      required super.shortDescription,
      required super.webLongDescription,
      required super.itemPrice,
      required super.currency,
      required super.discountPercent,
      required super.discountAmount,
      required super.discountedPrice,
      required super.inStock,
      required super.maintaneStock,
      required super.productOptions,
      required super.productSpecifications,
      required super.additionalImages});

  factory DetailedProductModel.fromJson(Map<String, dynamic> json) {
    return DetailedProductModel(
      websiteItemId: json['website_item_id'],
      itemCode: json['item_code'],
      websiteItemName: json['website_item_name'],
      itemGroup: json['item_group'],
      stockUom: json['stock_uom'],
      itemDescription: json['item_description'],
      backgroundColor: json['background_color'],
      published: json['published'],
      websiteImage: SharedFunctions.getImageUrl(json['website_image']),
      shortDescription: json['short_description'],
      webLongDescription: json['web_long_description'],
      itemPrice: json['item_price'],
      currency: json['currency'],
      discountPercent: json['discount_percent'],
      discountAmount: json['discount_amount'],
      discountedPrice: json['discounted_price'],
      inStock: json['in_stock'],
      maintaneStock: json['maintane_stock'],
      productOptions: List<ProductOptionModel>.from(
          json['product_options'].map((x) => ProductOptionModel.fromJson(x))),
      productSpecifications: List<ProductSpecificationModel>.from(
          json['product_specifications']
              .map((x) => ProductSpecificationModel.fromJson(x))),
      additionalImages: List<AdditionalImageModel>.from(
          json['additional_images']
              .map((x) => AdditionalImageModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['website_item_id'] = websiteItemId;
    map['item_code'] = itemCode;
    map['website_item_name'] = websiteItemName;
    map['item_group'] = itemGroup;
    map['stock_uom'] = stockUom;
    map['item_description'] = itemDescription;
    map['background_color'] = backgroundColor;
    map['published'] = published;
    map['website_image'] = websiteImage;
    map['short_description'] = shortDescription;
    map['web_long_description'] = webLongDescription;
    map['item_price'] = itemPrice;
    map['currency'] = currency;
    map['discount_percent'] = discountPercent;
    map['discount_amount'] = discountAmount;
    map['discounted_price'] = discountedPrice;
    map['in_stock'] = inStock;
    map['maintane_stock'] = maintaneStock;
    map['product_options'] =
        productOptions.map((v) => (v as ProductOptionModel).toJson()).toList();
    map['product_specifications'] = productSpecifications
        .map((v) => (v as ProductSpecificationModel).toJson())
        .toList();
    map['additional_images'] = additionalImages
        .map((v) => (v as AdditionalImageModel).toJson())
        .toList();
    return map;
  }
}
