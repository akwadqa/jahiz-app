import 'package:flutter/material.dart';
import '../../../domain/entities/detailed_product.dart';
import 'product_details_sliver_app_bar.dart';
import 'product_details_sliver_list.dart';
import 'product_details_tabs.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({Key? key, required this.detailedProduct})
      : super(key: key);
  final DetailedProduct detailedProduct;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ProductDetailsSliverAppBar(detailedProduct: detailedProduct),
        ProductDetailsSliverList(detailedProduct: detailedProduct),
        SliverFillRemaining(
            child: ProductDetailsTabs(detailedProduct: detailedProduct))
      ],
    );
  }
}
