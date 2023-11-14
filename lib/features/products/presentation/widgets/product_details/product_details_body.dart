import 'package:flutter/material.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/core/theme/app_colors.dart';
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

  static const double _expandedThresholdWithNotch = 0.3;
  static const double _expandedThresholdWithoutNotch = 0.33;

  @override
  Widget build(BuildContext context) {
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
          if (widget.detailedProductState is DetailedProductLoadSuccess) ...[
            ProductDetailsSliverList(
                detailedProduct:
                    (widget.detailedProductState as DetailedProductLoadSuccess)
                        .detailedProduct),
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
        if (_isAppBarExpanded) const _ShadowContainer(),
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

      if (_isAppBarExpanded != shouldExpand) {
        setState(() => _isAppBarExpanded = shouldExpand);
      }
    }
    return false;
  }
}

class _ShadowContainer extends StatelessWidget {
  const _ShadowContainer();

  static const double _shadowPositionWithNotch = 0.47;
  static const double _shadowPositionWithoutNotch = 0.44;
  static const double _shadowHeightWithNotch = 0.04;
  static const double _shadowHeightWithoutNotch = 0.05;

  @override
  Widget build(BuildContext context) {
    final bool hasNotch = SharedFunctions.hasNotch(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double topPosition = screenHeight *
        (hasNotch ? _shadowPositionWithNotch : _shadowPositionWithoutNotch);
    final double shadowHeight = screenHeight *
        (hasNotch ? _shadowHeightWithNotch : _shadowHeightWithoutNotch);

    return SliverPositioned(
      top: topPosition,
      left: 0,
      right: 0,
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
        height: shadowHeight,
      ),
    );
  }
}
