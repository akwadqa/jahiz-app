import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jahiz/core/widgets/custom_through_line.dart';
import 'package:jahiz/features/app_settings/domain/entities/app_settings.dart';
import 'package:jahiz/features/app_settings/presentation/bloc/app_settings_cubit.dart';
import 'package:jahiz/features/auth/application/auth_cubit.dart';
import 'package:jahiz/features/auth/presentation/widgets/sign_up_login_bottom_sheet.dart';
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
      Fluttertoast.showToast(
          msg: state.message,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Widget _productContent(BuildContext context) {
    final bool isSmallestPremiumItem =
        viewType == ViewType.premium && index > 0;
    return Center(
      child: Column(
        children: [
          _productImage(),
          _productDetails(
              context, isSmallestPremiumItem, viewType == ViewType.grid),
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

  Widget _productDetails(
      BuildContext context, bool isSmallestPremiumItem, bool isGrid) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0, left: 8.0, right: 8.0, bottom: isGrid ? 0.0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _productInfo(context, isSmallestPremiumItem),
          if (!isSmallestPremiumItem && viewType != ViewType.grid)
            _addToCartButton(context),
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
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontFamily: FontFamily.qatar,
                  color: Colors.black,
                  fontSize: 13),
              children: [
                TextSpan(
                  text: product.productTitle,
                  style: TextStyle(
                    fontSize: isSmallestPremiumItem ? 13 : 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midnight,
                  ),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (!isSmallestPremiumItem) ...[
          const Text(' - '),
          Flexible(
            child: Text(
              product.stockUom,
            ),
          ),
        ],
      ],
    );
  }

  Widget _addToCartButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: BlocBuilder<AddToCartCubit, AddToCartState>(
        builder: (context, state) {
          if (state is AddToCartLoading &&
              state.productId == product.productId) {
            return const CircularProgressIndicator.adaptive();
          }
          return IconButton(
            onPressed: () => _addToCart(context),
            icon: const Icon(Icons.add_circle_outline),
            iconSize: viewType == ViewType.premium ? 50 : 40,
            color: Theme.of(context).primaryColor,
          );
        },
      ),
    );
  }

  Widget _gridActionButton(BuildContext context) {
    return BlocBuilder<AddToCartCubit, AddToCartState>(
      builder: (context, state) {
        if (state is AddToCartLoading && state.productId == product.productId) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator.adaptive(),
          );
        }
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
      },
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
      if (context.read<AuthCubit>().state is Authenticated) {
        context.read<AddToCartCubit>().addToCart(product);
      } else {
        showSignUpLoginBottomSheet(context);
      }
    }
  }
}
