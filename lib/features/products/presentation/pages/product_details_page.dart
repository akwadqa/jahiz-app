import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/slider_indicator_cubit.dart';
import '../bloc/detailed_product/detailed_product_cubit.dart';
import '../widgets/product_details/product_details_body.dart';
import '../../../../injection_container.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../bloc/add_detailed_product_to_cart/add_detailed_product_to_cart_cubit.dart';
import '../bloc/price_modifier/price_modifier_cubit.dart';
import '../widgets/product_details/add_to_cart_button.dart';

@RoutePage()
class ProductDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  const ProductDetailsPage({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DetailedProductCubit, DetailedProductState>(
        builder: (context, state) {
          if (state is DetailedProductLoadInProgress) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is DetailedProductLoadFailure) {
            return AppErrorWidget(
                errorText: state.error,
                onRetryClicked: () => context
                    .read<DetailedProductCubit>()
                    .getDetailedProduct(productId));
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<PriceModifierCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<AddDetailedProductToCartCubit>(),
              ),
            ],
            child: Stack(
              children: [
                ProductDetailsBody(
                    detailedProduct:
                        (state as DetailedProductLoadSuccess).detailedProduct),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 20.0, start: 20, end: 20),
                    child:
                        AddToCartButton(detailedProduct: state.detailedProduct),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<SliderIndicatorCubit>()),
      BlocProvider(
          create: (_) => getIt<DetailedProductCubit>(param1: productId)),
    ], child: this);
  }
}
