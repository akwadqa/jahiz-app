import 'package:flutter/material.dart';
import 'package:jahiz/features/home/domain/entities/home_block.dart';
import '../../../../core/shared_functions.dart';
import '../../../products/domain/entities/product.dart';
import 'dynamic_layout.dart';
import '../../../products/presentation/widgets/product_item.dart';

class ProductsView extends StatelessWidget {
  const ProductsView(
      {Key? key, required this.productsBlock, required this.isNotLast})
      : super(key: key);
  final HomeBlock<Product> productsBlock;
  final bool isNotLast;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: isNotLast ? const EdgeInsets.only(bottom: 30) : EdgeInsets.zero,
      sliver: DynamicLayout(
        title: productsBlock.title,
        viewType: ViewType.values
            .firstWhere((element) => element.name == productsBlock.view),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.zero,
            child: SizedBox(
                width: ViewType.values.firstWhere(
                            (element) => element.name == productsBlock.view) ==
                        ViewType.horizontalScroll
                    ? 200
                    : null,
                child: ProductItem(
                  product: productsBlock.data[index],
                  viewType: ViewType.values.firstWhere(
                      (element) => element.name == productsBlock.view),
                  index: index,
                )),
          );
        },
        count: productsBlock.data.length,
        backgroundColor: SharedFunctions.getColor(productsBlock.background),
      ),
    );
  }
}
