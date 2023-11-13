import 'package:flutter/material.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../domain/entities/detailed_product.dart';
import 'product_details_sliver_app_bar.dart';
import 'product_details_sliver_list.dart';
import 'product_details_tabs.dart';

class ProductDetailsBody extends StatefulWidget {
  final DetailedProduct detailedProduct;

  const ProductDetailsBody({Key? key, required this.detailedProduct})
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
          ProductDetailsSliverList(detailedProduct: widget.detailedProduct),
          SliverFillRemaining(
              child:
                  ProductDetailsTabs(detailedProduct: widget.detailedProduct)),
        ],
      ),
    );
  }

  Widget _buildSliverStack() {
    return SliverStack(
      children: [
        ProductDetailsSliverAppBar(detailedProduct: widget.detailedProduct),
        if (_isAppBarExpanded) const _ShadowContainer(),
      ],
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      final double screenHeight = MediaQuery.of(context).size.height;
      final bool hasNotch = SharedFunctions.hasNotch(context);
      final double threshold =
          hasNotch ? _expandedThresholdWithNotch : _expandedThresholdWithoutNotch;
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
