import 'package:flutter/material.dart' hide Banner;
import 'package:jahiz/features/home/domain/entities/banner.dart';
import 'package:jahiz/features/home/domain/entities/category.dart';
import 'package:jahiz/features/home/presentation/widgets/banners_view.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/home/presentation/widgets/categories_view.dart';
import 'package:jahiz/features/home/presentation/widgets/home/products_view.dart';
import '../../domain/entities/home_block.dart';
import '../../domain/entities/home_block_data.dart';

class DynamicItem extends StatelessWidget {
  const DynamicItem(
      {Key? key, required this.homeBlock, required this.isNotLast})
      : super(key: key);
  final HomeBlock<HomeBlockData> homeBlock;
  final bool isNotLast;
  @override
  Widget build(BuildContext context) {
    if (homeBlock is HomeBlock<Banner>) {
      return BannersView(
          bannersBlock: homeBlock as HomeBlock<Banner>,
          isNotLast: isNotLast);
    } else if (homeBlock is HomeBlock<Category>) {
      return CategoriesView(
          categoriesBlock: homeBlock as HomeBlock<Category>,
          isNotLast: isNotLast);
    }
    return ProductsView(
        productsBlock: homeBlock as HomeBlock<Product>, isNotLast: isNotLast);
  }
}
