import 'package:equatable/equatable.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';

class Category extends Equatable {
  final String itemGroupId;
  final String? parentItemGroup;
  final String? websiteTitle;
  final String? description;
  final List<Product>? products;
  final List<Category>? subCategories;
  final String? image;

  const Category(
      {required this.itemGroupId,
      required this.parentItemGroup,
      required this.websiteTitle,
      required this.description,
      required this.products,
      required this.subCategories,
      required this.image});

  Category copyWith(
          {String? itemGroupId,
          String? parentItemGroup,
          String? websiteTitle,
          String? description,
          List<Product>? products,
          List<Category>? subCategories,
          String? image}) =>
      Category(
          itemGroupId: itemGroupId ?? this.itemGroupId,
          parentItemGroup: parentItemGroup ?? this.parentItemGroup,
          websiteTitle: websiteTitle ?? this.websiteTitle,
          description: description ?? this.description,
          products: products ?? this.products,
          subCategories: subCategories ?? this.subCategories,
          image: image ?? this.image);

  @override
  List<Object?> get props => [
        itemGroupId,
        parentItemGroup,
        websiteTitle,
        description,
        products,
        subCategories,
        image
      ];
}
