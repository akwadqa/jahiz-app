import '../../../../core/shared_functions.dart';
import '../../domain/entities/category.dart';

import 'home_block_data_model.dart';

class CategoryModel extends Category implements HomeBlockDataModel {
  const CategoryModel(
      {required super.categoryImage,
      required super.backgroundColor,
      required super.categoryName,
      required super.categoryTitle,
      required super.categoryRoute,
      required super.categoryView,
      required super.categoryWeightage,
      required super.subCategories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryImage: SharedFunctions.getImageUrl(
            json['category_image'] ?? '/files/Apple Store.png'),
        backgroundColor: json['background_color'] ?? '#ED6396',
        categoryName: json['category_name'],
        categoryTitle: json['category_title'] ?? '',
        categoryRoute: json['category_route'],
        categoryView: json['category_view'],
        categoryWeightage: json['category_weightage'],
        subCategories: json['sub_categories'] != null
            ? (json['sub_categories'] as List)
                .map<CategoryModel>((e) => CategoryModel.fromJson(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_image'] = categoryImage;
    map['background_color'] = backgroundColor;
    map['category_name'] = categoryName;
    map['category_title'] = categoryTitle;
    map['category_route'] = categoryRoute;
    map['category_view'] = categoryView;
    map['category_weightage'] = categoryWeightage;
    if (subCategories != null) {
      map['sub_categories'] =
          subCategories!.map((v) => (v as CategoryModel).toJson()).toList();
    }
    return map;
  }
}
