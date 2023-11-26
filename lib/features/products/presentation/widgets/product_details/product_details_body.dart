import 'package:flutter/material.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/products/presentation/bloc/detailed_product/detailed_product_cubit.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'product_details_sliver_app_bar.dart';
import 'product_details_sliver_list.dart';
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
  bool _isAppBarExpanded = true;
  double reminingValue = 0.0;

  static const double _expandedThresholdWithNotch = 0.3;
  static const double _expandedThresholdWithoutNotch = 0.35;

  @override
  Widget build(BuildContext context) {
    final bool isLoadSuccess =
        widget.detailedProductState is DetailedProductLoadSuccess;
    DetailedProduct? detailedProduct;
    bool hasProductOptions = false;
    bool hasWebLongDescription = false;
    bool hasProductSpecifications = false;
    if (isLoadSuccess) {
      final detailedProductSuccess =
          widget.detailedProductState as DetailedProductLoadSuccess;
      detailedProduct = detailedProductSuccess.detailedProduct;

      hasProductOptions = detailedProduct.productOptions.isNotEmpty;
      hasWebLongDescription =
          detailedProduct.webLongDescription?.isNotEmpty ?? false;
      hasProductSpecifications =
          detailedProduct.productSpecifications.isNotEmpty;
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        slivers: [
          _buildSliverStack(),
          if (widget.detailedProductState is DetailedProductLoadInProgress)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          if (isLoadSuccess) ...[
            ProductDetailsSliverList(detailedProduct: detailedProduct!),
            if (hasProductOptions ||
                hasWebLongDescription ||
                hasProductSpecifications)
              SliverFillRemaining(
                  child: ProductDetailsTabs(
                      detailedProduct: (widget.detailedProductState
                              as DetailedProductLoadSuccess)
                          .detailedProduct))
          ],
        ],
      ),
    );
  }

  Widget _buildSliverStack() {
    return SliverStack(
      children: [
        ProductDetailsSliverAppBar(
            detailedProductState: widget.detailedProductState,
            product: widget.product,
            heroTag: widget.heroTag),
        _ShadowContainer(
          reminingValue: reminingValue,
        ),
      ],
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      final double screenHeight = MediaQuery.of(context).size.height;
      final bool hasNotch = SharedFunctions.hasNotch(context);
      final double threshold = hasNotch
          ? _expandedThresholdWithNotch
          : _expandedThresholdWithoutNotch;
      final bool shouldExpand =
          notification.metrics.pixels < screenHeight * threshold;

      double appBarHeight =
          kToolbarHeight + MediaQuery.of(context).padding.top - 10;
      double stackSize =
          MediaQuery.of(context).size.height * (hasNotch ? 0.44 : 0.45);
      if (notification.metrics.pixels > stackSize - appBarHeight - 10 &&
          notification.metrics.pixels < stackSize - appBarHeight) {
        setState(() {
          reminingValue = reminingValue + 2.0;
        });
      } else {
        setState(() {
          reminingValue = 0.0;
        });
      }
      if (notification.metrics.pixels > stackSize - appBarHeight) {
        setState(() {
          reminingValue = 40.0;
        });
      }
      if (_isAppBarExpanded != shouldExpand) {
        setState(() {
          _isAppBarExpanded = shouldExpand;
        });
      }
    }
    return false;
  }
}

class _ShadowContainer extends StatelessWidget {
  final double reminingValue;
  const _ShadowContainer({required this.reminingValue});

  static const double _fixedHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final double fixedHeight =
        reminingValue < _fixedHeight ? _fixedHeight - reminingValue : 0.0;

    return SliverPositioned(
      left: 0,
      right: 0,
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(40),
            topStart: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: AppColors.shadowColor,
              offset: const Offset(0, -7),
            ),
          ],
        ),
        height: fixedHeight,
      ),
    );
  }
}
