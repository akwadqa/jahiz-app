import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jahiz/core/widgets/custom_through_line.dart';
import 'package:jahiz/features/app_settings/domain/entities/app_settings.dart';
import 'package:jahiz/features/app_settings/presentation/bloc/app_settings_cubit.dart';
import '../../../../core/gen/fonts.gen.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../domain/entities/product.dart';
import '../bloc/add_to_cart/add_to_cart_cubit.dart';
import '../../../home/presentation/widgets/dynamic_layout.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.product,
      required this.viewType,
      required this.index})
      : super(key: key);
  final Product product;
  final ViewType viewType;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) => previous != current,
      listener: _addToCartListener,
      child: CustomContainer(
        onTap: () => context.pushRoute(
            ProductDetailsRoute(product: product, heroTag: _heroTag)),
        child: Stack(
          children: [
            _productContent(context),
            if (product.discountAmount > 0) _discountBadge(),
          ],
        ),
      ),
    );
  }

  void _addToCartListener(BuildContext context, AddToCartState state) {
    if (state is AddToCartError) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: state.message,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else if (state is AddToCartLoading) {
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, _, __) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          opaque: false,
          barrierColor: Colors.black.withOpacity(0.1)));
    } else {
      Navigator.pop(context);
    }
  }

  Widget _productContent(BuildContext context) {
    final bool isSmallestPremiumItem =
        viewType == ViewType.premium && index > 0;
    return Center(
      child: Column(
        children: [
          _productImage(),
          _productDetails(context, isSmallestPremiumItem),
          if (viewType == ViewType.grid) _gridActionButton(context),
        ],
      ),
    );
  }

  Widget _productImage() {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Hero(
          tag: _heroTag,
          child: AppCachedNetworkImage(
              imageUrl: product.productImage, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  String get _heroTag => '${product.productId}${viewType.name}}';

  Widget _productDetails(BuildContext context, bool isSmallestPremiumItem) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _productInfo(context, isSmallestPremiumItem),
          if (!isSmallestPremiumItem && viewType != ViewType.grid)
            _addToCartButton(context, isSmallestPremiumItem),
        ],
      ),
    );
  }

  Widget _productInfo(BuildContext context, bool isSmallestPremiumItem) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productPrice(context, isSmallestPremiumItem),
          SizedBox(height: isSmallestPremiumItem ? 2 : 4),
          _productTitle(context, isSmallestPremiumItem),
        ],
      ),
    );
  }

  Widget _productPrice(BuildContext context, bool isSmallestPremiumItem) {
    return Wrap(
      children: [
        Text('${product.discountedPrice} ${S.of(context).qar}',
            style: TextStyle(
                fontSize: isSmallestPremiumItem ? 13 : 15,
                fontWeight: FontWeight.bold,
                color: AppColors.midnight)),
        if (!isSmallestPremiumItem) const SizedBox(width: 8),
        if (product.discountAmount > 0 && !isSmallestPremiumItem)
          CustomThroughLine(
              productPrice: '${product.productPrice} ${S.of(context).qar}',
              isSmallestPremiumItem: isSmallestPremiumItem),
      ],
    );
  }

  Widget _productTitle(BuildContext context, bool isSmallestPremiumItem) {
    return Wrap(
      children: [
        Text(product.productTitle,
            style: TextStyle(
                fontSize: isSmallestPremiumItem ? 13 : 16,
                fontWeight: FontWeight.w500,
                color: AppColors.midnight)),
        if (!isSmallestPremiumItem) ...[
          const SizedBox(width: 5),
          Text("- ${product.stockUom}")
        ],
      ],
    );
  }

  Widget _addToCartButton(BuildContext context, bool isSmallestPremiumItem) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: IconButton(
        onPressed: () => _addToCart(context),
        icon: const Icon(Icons.add_circle_outline),
        iconSize: viewType == ViewType.premium ? 50 : 40,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _gridActionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _addToCart(context),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        minimumSize: MaterialStateProperty.all(const Size(100, 20)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4)),
        textStyle: MaterialStateProperty.all(const TextStyle(
            fontFamily: FontFamily.qatar,
            fontSize: 13,
            fontWeight: FontWeight.w700)),
      ),
      child: Text(product.hasOptions == 0
          ? S.of(context).addToCart
          : S.of(context).goToProduct),
    );
  }

  Widget _discountBadge() {
    return BlocBuilder<AppSettingsCubit, AppSettings?>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            color: state != null ? HexColor(state.textColor) : AppColors.red,
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(17))),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text('-${product.discountPercent}',
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      );
    });
  }

  void _addToCart(BuildContext context) {
    if (product.hasOptions == 1) {
      context
          .pushRoute(ProductDetailsRoute(product: product, heroTag: _heroTag));
    } else {
      context.read<AddToCartCubit>().addToCart(product);
    }
  }
}
