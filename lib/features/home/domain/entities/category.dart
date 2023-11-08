import 'package:equatable/equatable.dart';
import 'home_block_data.dart';

class Category extends Equatable implements HomeBlockData {
  final String categoryImage;
  final String backgroundColor;
  final String categoryName;
  final String categoryTitle;
  final String categoryRoute;
  final String? categoryView;
  final int categoryWeightage;
  final List<Category>? subCategories;

  const Category(
      {required this.categoryImage,
      required this.backgroundColor,
      required this.categoryName,
      required this.categoryTitle,
      required this.categoryRoute,
      required this.categoryView,
      required this.categoryWeightage,
      required this.subCategories});

  Category copyWith({
    String? categoryImage,
    String? backgroundColor,
    String? categoryName,
    String? categoryTitle,
    String? categoryRoute,
    String? categoryView,
    int? categoryWeightage,
    List<Category>? subCategories,
  }) =>
      Category(
        categoryImage: categoryImage ?? this.categoryImage,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        categoryName: categoryName ?? this.categoryName,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        categoryRoute: categoryRoute ?? this.categoryRoute,
        categoryView: categoryView ?? this.categoryView,
        categoryWeightage: categoryWeightage ?? this.categoryWeightage,
        subCategories: subCategories ?? this.subCategories,
      );

  @override
  List<Object?> get props => [
        categoryImage,
        backgroundColor,
        categoryName,
        categoryTitle,
        categoryRoute,
        categoryView,
        categoryWeightage,
        subCategories
      ];
}
