import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/features/categories/domain/entities/category.dart';
import 'package:jahiz/features/products/data/models/product_model.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.itemGroupId,
      required super.parentItemGroup,
      required super.websiteTitle,
      required super.description,
      required super.products,
      required super.subCategories,
      required super.image});

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
        itemGroupId: json['item_group_id'],
        parentItemGroup: json['parent_item_group'],
        websiteTitle: json['website_title'],
        description: json['description'],
        products: json['products'] != null
            ? (json['products'] as List)
                .map((e) => ProductModel.fromJson(e))
                .toList()
            : null,
        subCategories: json['sub_categories'] != null
            ? (json['sub_categories'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList()
            : null,
        image: json['image'] != null
            ? SharedFunctions.getImageUrl(json['image'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_group_id'] = itemGroupId;
    map['parent_item_group'] = parentItemGroup;
    map['website_title'] = websiteTitle;
    map['description'] = description;
    if (products != null) {
      map['products'] =
          products?.map((v) => (v as ProductModel).toJson()).toList();
    }
    if (subCategories != null) {
      map['sub_categories'] =
          subCategories?.map((v) => (v as CategoryModel).toJson()).toList();
    }
    map['image'] = image;
    return map;
  }
}
