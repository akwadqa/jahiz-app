import 'package:flutter/material.dart';
import 'package:jahiz/features/products/domain/entities/banner.dart'
    as banner_entity;
import 'package:jahiz/features/products/domain/entities/category.dart'
    as category_entity;
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/products/presentation/widgets/home/banners_view.dart';
import 'package:jahiz/features/products/presentation/widgets/home/categories_view.dart';
import 'package:jahiz/features/products/presentation/widgets/home/products_view.dart';
import '../../../domain/entities/home_block.dart';
import '../../../domain/entities/home_block_data.dart';

class DynamicItem extends StatelessWidget {
  const DynamicItem(
      {Key? key, required this.homeBlock, required this.isNotLast})
      : super(key: key);
  final HomeBlock<HomeBlockData> homeBlock;
  final bool isNotLast;
  @override
  Widget build(BuildContext context) {
    if (homeBlock is HomeBlock<banner_entity.Banner>) {
      return BannersView(
          bannersBlock: homeBlock as HomeBlock<banner_entity.Banner>,
          isNotLast: isNotLast);
    } else if (homeBlock is HomeBlock<category_entity.Category>) {
      return CategoriesView(
          categoriesBlock: homeBlock as HomeBlock<category_entity.Category>,
          isNotLast: isNotLast);
    }
    return ProductsView(
        productsBlock: homeBlock as HomeBlock<Product>, isNotLast: isNotLast);
  }
}
