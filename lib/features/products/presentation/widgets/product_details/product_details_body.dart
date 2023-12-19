import 'package:flutter/material.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/products/presentation/bloc/detailed_product/detailed_product_cubit.dart';
import 'product_details_sliver_app_bar.dart';
import 'product_details_tabs.dart';

class ProductDetailsBody extends StatefulWidget {
  final DetailedProductState detailedProductState;
  final Product product;
  final String heroTag;

  const ProductDetailsBody(
      {Key? key,
      required this.detailedProductState,
      required this.product,
      required this.heroTag})
      : super(key: key);

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
  final ScrollController _customScrollViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    _draggableScrollableController.addListener(() {
      // Synchronize the custom scroll view with the draggable scrollable sheet
      double draggableExtent = _draggableScrollableController.size;
      double customScrollViewOffset = _customScrollViewController.offset;
      double syncOffset =
          draggableExtent * 50; // Customize this factor as needed

      if (syncOffset != customScrollViewOffset) {
        _customScrollViewController.jumpTo(syncOffset);
      }
    });
  }

  @override
  void dispose() {
    _customScrollViewController.dispose();
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoadSuccess =
        widget.detailedProductState is DetailedProductLoadSuccess;

    return Stack(
      children: [
        CustomScrollView(
          controller: _customScrollViewController,
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ProductDetailsSliverAppBar(
                detailedProductState: widget.detailedProductState,
                product: widget.product,
                heroTag: widget.heroTag),
            if (widget.detailedProductState is! DetailedProductLoadInProgress)
              const SliverToBoxAdapter(child: SizedBox(height: 800)),
          ],
        ),
        DraggableScrollableSheet(
            shouldCloseOnMinExtent: false,
            minChildSize: 0.6,
            initialChildSize: 0.6,
            controller: _draggableScrollableController,
            builder: (_, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(50),
                    topStart: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: AppColors.shadowColor,
                      offset: const Offset(0, -7),
                    ),
                  ],
                ),
                child: isLoadSuccess
                    ? SingleChildScrollView(
                        controller: scrollController,
                        child: ProductDetailsTabs(
                            detailedProduct: (widget.detailedProductState
                                    as DetailedProductLoadSuccess)
                                .detailedProduct),
                      )
                    : (widget.detailedProductState
                            is DetailedProductLoadInProgress)
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const SizedBox.shrink(),
              );
            })
      ],
    );
  }
}
