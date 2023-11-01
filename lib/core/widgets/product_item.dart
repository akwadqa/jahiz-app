import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jahiz/core/router/app_router.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/core/widgets/custom_container.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/products/presentation/bloc/add_to_cart/add_to_cart_cubit.dart';
import 'package:jahiz/features/products/presentation/widgets/home/dynamic_layout.dart';
import 'package:jahiz/generated/l10n.dart';

import 'app_cached_network_image.dart';

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
    final bool isSmallestPremiumItem =
        viewType == ViewType.premium && index > 0;
    return BlocListener<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is AddToCartError) {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        } else if (state is AddToCartLoading) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, _, __) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              opaque: false,
              barrierColor: Colors.black.withOpacity(0.1),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: CustomContainer(
        onTap: () => context
            .pushRoute(ProductDetailsRoute(productId: product.productId)),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                        width: double.maxFinite,
                        child: AppCachedNetworkImage(
                          imageUrl: product.productImage,
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  Text(
                                      '${product.discountedPrice} ${S.of(context).qar}',
                                      style: TextStyle(
                                          fontSize:
                                              isSmallestPremiumItem ? 13 : 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.midnight)),
                                  if (!isSmallestPremiumItem)
                                    const SizedBox(width: 8),
                                  if (product.discountAmount > 0 &&
                                      !isSmallestPremiumItem)
                                    Text(
                                        '${product.productPrice} ${S.of(context).qar}',
                                        style: TextStyle(
                                            fontSize:
                                                isSmallestPremiumItem ? 11 : 13,
                                            color: AppColors.lightGray,
                                            decoration:
                                                TextDecoration.lineThrough))
                                ],
                              ),
                              SizedBox(height: isSmallestPremiumItem ? 4 : 8),
                              Wrap(
                                children: [
                                  Text(product.productTitle,
                                      style: TextStyle(
                                          fontSize:
                                              isSmallestPremiumItem ? 13 : 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.midnight)),
                                  if (!isSmallestPremiumItem) ...[
                                    const SizedBox(width: 5),
                                    Text(S.of(context).pack)
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!isSmallestPremiumItem && viewType != ViewType.grid)
                          Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: IconButton(
                                  onPressed: () => _addToCart(context),
                                  icon: const Icon(Icons.add_circle_outline),
                                  iconSize:
                                      viewType == ViewType.premium ? 50 : 40,
                                  color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                  if (viewType == ViewType.grid) ...[
                    ElevatedButton(
                        onPressed: () => _addToCart(context),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            minimumSize:
                                MaterialStateProperty.all(const Size(100, 20)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(8.0)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700))),
                        child: Text(product.hasOptions == 0
                            ? S.of(context).addToCart
                            : S.of(context).goToProduct)),
                    const SizedBox(height: 10)
                  ]
                ],
              ),
            ),
            if (product.discountAmount > 0)
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(17))),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('-${product.discountPercent}',
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              )
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    if (product.hasOptions == 1) {
      context.pushRoute(ProductDetailsRoute(productId: product.productId));
    } else {
      context.read<AddToCartCubit>().addToCart(product);
    }
  }
}
